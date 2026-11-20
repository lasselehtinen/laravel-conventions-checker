# Changelog

## Unreleased (v7.0.0)

### Breaking changes
- Requires PHP 8.2 or newer, `phpro/grumphp` ^2.27 and `larastan/larastan` ^3.15
- PHPMD 3 is now required and run with grumphp's `phpmd3` task. PHPMD 2 can't be installed together with Laravel 13 / symfony 8
- Removed the phpcs task and the `squizlabs/php_codesniffer` dependency. Code style is now checked with Laravel Pint (`vendor/bin/pint --test`)

### Added
- Support for PHP 8.6
- The commit blacklist now also catches `dd()`, `ddd()`, `dump()`, `ray()`, `exit()` and `die;`
- PHPMD now also checks the `resources` directory (the pattern was previously misspelled as `recources`)
- README sections for allowing the grumphp Composer plugin and for overriding tasks, e.g. using Pest instead of PHPUnit
- CI workflow that installs the package into a fresh Laravel skeleton and runs all checks on PHP 8.2 - 8.6

### Changed
- Security check uses `composer audit` instead of Local PHP Security Checker, which no longer needs to be downloaded
- PHPMD no longer reports `ElseExpression` or `BooleanArgumentFlag`

## v6.0.0 - 2024-11-15
- Updated to larastan/phpstan 2.0

## v5.0.0 - 2023-12-19
- Upgraded grumphp

## v4.0.1 - 2023-12-08
- Switched larastan to the new `larastan/larastan` package

## v4.0.0 - 2022-02-09
- Added support for Laravel 9

## v3.1.0 - v3.1.6 - 2021-10-27 - 2021-11-19
- Added phplint for syntax checking and reorganized test suites
- Ignore Nova sources
- Upgraded to larastan v1

## v3.0 - 2021-05-17
- Upgraded packages to support PHP 8
