#!/usr/bin/env sh

set -e
# first we check if a release already exists. We can't use the GET release by tag endpoint because
# draft releases aren't tagged using the format we expect. Instead we list all releases and filter
# using JQ to see if a release with the provided name already exists.
listReleasesStatusCode=$(curl \
  --silent \
  -H "Authorization: Bearer ${loginPassword}" \
  -X GET "https://api.github.com/repos/${owner}/${repo}/releases?per_page=30" \
  --output response \
  --write-out "%{http_code}"
)

if test "$listReleasesStatusCode" -ne 200; then
  echo "Failed to list releases with status code $listReleasesStatusCode"
  exit 1
fi

results=$(cat response | jq ".[] | select(.name == \"$name\") | [.id]")

echo "Results: $results"

# If more than one release with the same name exists, something has gone wrong.
# This op isn't responsible for figuring out which release to use, so we fail and
# give the user some information about how to fix the issue.
moreThanOne=$(echo "$results" | jq 'length > 1')
if [ "$moreThanOne" = "true" ]; then
  echo "More than one release with name $name already exists"
  echo "You can fix this by manually deleting the duplicate release(s) in the GitHub UI and then rerunning this op."
  exit 1
fi

# If a release with the given name does exist, output that release's ID and exit.
if [ -n "$results" ]; then
  echo "Release with name $name already exists"
  echo "$results" | jq '.[0]' | tr -d '\n' > /id
  exit 0
else
  echo "No release with name $name exists"
fi

cat > body <<EOF
{
  "tag_name": "$tag",
  "target_commitish": "$commitish",
  "name": "$name",
  "body": "$description",
  "draft": $isDraft,
  "prerelease": $isPrerelease,
  "generate_release_notes": true
}
EOF

statusCode=$(curl \
    --silent \
    --output response \
    --write-out "%{http_code}" \
    --user "${loginUsername}:${loginPassword}" \
    -X POST "https://api.github.com/repos/${owner}/${repo}/releases" \
    -d @body)

if test "$statusCode" -ne 201; then
  echo "Failed to create release with status code $statusCode"
  exit 1
fi

# Record the release ID
cat response | jq -r .id | tr -d '\n' > /id
