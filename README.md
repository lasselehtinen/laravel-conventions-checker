
## Goal

Configuration for [grumphp](https://github.com/phpro/grumphp) that is checking on each commit that the committed code passes the unit tests, complies with the PSR2 coding style and static analysis check. It runs the following checks:

 - Check that composer.json is valid
 - Check that composer does not have any dependencies for known security vulnerabilities with [Local PHP Security Checker](https://github.com/fabpot/local-php-security-checker)
- Check that commit does not contain any debugging (var_dump, die, exit)
 - Check that code complies with the PSR2 coding style
 - Perform static code analysis using [phpstan](https://github.com/phpstan/phpstan)
 - Check code for unnecessary complexity etc. with [PHP Mess Detector](https://github.com/phpmd/phpmd)
 - Check that unit tests pass with PHPUnit

## Installation

### 1. Add checker to your `composer.json`:

```
composer require --dev lasselehtinen/laravel-conventions-checker
```

### 2. Download Local PHP Security Checker

Download a binary from the [Releases page on Github](https://github.com/fabpot/local-php-security-checker/releases), rename it to `local-php-security-checker` and make it executable.

### 3. Add path to grumphp configuration file to your `composer.json`'s extra:

```
    "extra": {
        "grumphp": {
            "config-default-path": "vendor/lasselehtinen/laravel-conventions-checker/grumphp.yml"
        }
    }
```
## Test suites
If you want to run the coding style or static analysis checks only, you can run the following commands:
```
vendor/bin/grumphp run --testsuite=style
vendor/bin/grumphp run --testsuite=static
```

## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.