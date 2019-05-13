## Goal

Configuration for [grumphp](https://github.com/phpro/grumphp) that is checking on each commit that the committed code passes PSR2 and static analysis check.

## Installation

### 1. Add path to grumphp configuration file to your `composer.json`'s extra:

For application project:

```
    "extra": {
        "grumphp": {
            "config-default-path": "vendor/lasselehtinen/laravel-conventions-checker/grumphp.yml"
        }
    }
```

### 2. Add checker to your `composer.json`:

```
composer require --dev lasselehtinen/laravel-conventions-checker
```

