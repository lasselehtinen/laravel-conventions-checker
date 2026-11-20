
## Goal

Configuration for [grumphp](https://github.com/phpro/grumphp) that is checking on each commit that the committed code passes the unit tests, code style, mess detection and static analysis checks. It runs the following checks:

 - Check that composer.json is valid
 - Check that composer does not have any dependencies with known security vulnerabilities with [composer audit](https://getcomposer.org/doc/03-cli.md#audit)
 - Check that the PHP syntax is valid
 - Check that commit does not contain any debugging (`dd`, `dump`, `ddd`, `ray`, `var_dump`, `die`, `exit`)
 - Check that code complies with the Laravel coding style using [Laravel Pint](https://github.com/laravel/pint)
 - Perform static code analysis using [Larastan](https://github.com/larastan/larastan)
 - Check code for unnecessary complexity etc. with [PHP Mess Detector](https://github.com/phpmd/phpmd)
 - Check that unit tests pass with PHPUnit

## Requirements

 - PHP 8.2 - 8.6
 - Laravel project with Composer 2.2 or newer

## Installation

### 1. Add checker to your `composer.json`:

```
composer require --dev lasselehtinen/laravel-conventions-checker
```

### 2. Allow the grumphp Composer plugin

GrumPHP installs its git hooks through a Composer plugin, which needs to be allowed explicitly:

```
composer config allow-plugins.phpro/grumphp true
```

If you prefer to keep the plugin disabled, install the git hooks manually instead:

```
vendor/bin/grumphp git:init
```

### 3. Add path to grumphp configuration file to your `composer.json`'s extra:

```
    "extra": {
        "grumphp": {
            "config-default-path": "vendor/lasselehtinen/laravel-conventions-checker/grumphp.yml"
        }
    }
```

## Code style

Code style is checked with `vendor/bin/pint --test`. Pint uses your project's `pint.json` if present, otherwise the Laravel preset. Run `vendor/bin/pint` to fix the issues automatically.

Note that Pint checks the whole project, not just the committed files. When adding the checker to an existing project, run `vendor/bin/pint` once and commit the result, otherwise every commit will fail until the existing style issues are fixed.

## Customizing the checks

Instead of `config-default-path`, you can create a `grumphp.yml` in your project root that imports this configuration and overrides individual tasks. For example, to run tests with [Pest](https://pestphp.com) instead of PHPUnit:

```yaml
imports:
    - { resource: vendor/lasselehtinen/laravel-conventions-checker/grumphp.yml }

grumphp:
    tasks:
        phpunit:
            metadata: {enabled: false}
        pest:
            metadata: {priority: 100}
```

Any task can be disabled the same way with `metadata: {enabled: false}`, or made non-blocking with `metadata: {blocking: false}`.

## Test suites
If you want to run the coding syntax, style, static analysis or security checks only, you can run the following commands:
```
vendor/bin/grumphp run --testsuite=syntax
vendor/bin/grumphp run --testsuite=style
vendor/bin/grumphp run --testsuite=static
vendor/bin/grumphp run --testsuite=security
```

## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.
