# Change Log

All notable changes will be documented in this file in accordance with
[![keepachangelog 1.0.0](https://img.shields.io/badge/keepachangelog-1.0.0-brightgreen.svg)](http://keepachangelog.com/en/1.0.0/)

## \[Unreleased]

## \[2.0.1] - 2024-08-21

### Fixed
- if listing releases fails, fail the op immediately instead of trying to continue
- Correctly escape variables used in the `jq` command to find a release by name so that the command doesn't break when special characters in a name

## \[2.0.0] - 2024-05-28

### Added
- When creating a release fails, increase the amount of output so that errors are more transparent to consumers of the op

### Changed
- Instead of always creating a new release, make sure a release doesn't already exist with the provided tag/name

### Fixed
- CI wasn't running previously, migrate from Travis to GitHub Actions so contributors can easily see the status of CI runs

## \[1.2.0] - 2020-11-05

- added `id` output

## \[1.1.0] - 2018-03-07

### Added

- opspec 0.1.6 compatibility

## \[1.0.0] - 2017-06-22

