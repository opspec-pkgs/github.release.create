#!/usr/bin/env sh

set -e

cat > body <<EOF
{
  "tag_name": "$tag",
  "target_commitish": "$commitish",
  "name": "$name",
  "body": "$description",
  "draft": $isDraft,
  "prerelease": $isPrerelease
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
exit 1
fi

# Record the release ID
cat response | jq -r .id | tr -d '\n' > /id
