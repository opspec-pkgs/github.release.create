# Problem statement
creates a github release

# Example usage

> note: in examples, VERSION represents a version of the github.release.create pkg

## install

```shell
opctl pkg install github.com/opspec-pkgs/github.release.create#VERSION
```

## run

```
opctl run github.com/opspec-pkgs/github.release.create#VERSION
```

## compose

```yaml
op:
  pkg: { ref: github.com/opspec-pkgs/github.release.create#VERSION }
  inputs: 
    owner:
    repo:
    loginUsername:
    loginPassword:
    tag:
    commitish:
    # begin optional args
    name:
    description:
    isDraft:
    isPrerelease:
    # end optional args
```

# Support

join us on [![Slack](https://opspec-slackin.herokuapp.com/badge.svg)](https://opspec-slackin.herokuapp.com/)
or [open an issue](https://github.com/opspec-pkgs/github.release.create/issues)
