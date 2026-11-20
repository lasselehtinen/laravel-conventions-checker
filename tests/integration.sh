#!/usr/bin/env bash
#
# Installs this package into a fresh Laravel skeleton and checks that the
# grumphp configuration works end to end.
#
# Usage: tests/integration.sh [work-dir]

set -euo pipefail

PACKAGE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WORK_DIR="${1:-$(mktemp -d)}"
APP_DIR="$WORK_DIR/laravel"

step() { printf '\n==> %s\n' "$*"; }
fail() { printf '\nFAIL: %s\n' "$*" >&2; exit 1; }

step "Creating Laravel skeleton in $APP_DIR (PHP $(php -r 'echo PHP_VERSION;'))"
rm -rf "$APP_DIR"
composer create-project laravel/laravel "$APP_DIR" --no-interaction --prefer-dist --quiet

cd "$APP_DIR"
git init --quiet
git config user.name "CI"
git config user.email "ci@example.com"

step "Installing package from $PACKAGE_DIR"
composer config repositories.local "{\"type\": \"path\", \"url\": \"$PACKAGE_DIR\", \"options\": {\"symlink\": false, \"versions\": {\"lasselehtinen/laravel-conventions-checker\": \"dev-ci\"}}}"
composer config allow-plugins.phpro/grumphp true
composer config extra.grumphp.config-default-path vendor/lasselehtinen/laravel-conventions-checker/grumphp.yml
composer require --dev lasselehtinen/laravel-conventions-checker:dev-ci --no-interaction --no-progress

step "Running all grumphp tasks"
git add --all
git commit --quiet --no-verify -m "Initial commit"
vendor/bin/grumphp run --no-interaction

step "git_blacklist rejects debug calls"
for call in 'dd($user);' 'dd(true);' 'dump($user);' 'dump(1);' 'ddd($user);' 'ray($user);' \
    'var_dump($user);' '$user->dd();' 'die("x");' 'die;' 'exit;' 'exit(1);' 'exit (1);'; do
    printf '<?php\n\nnamespace App;\n\nfunction debug($user)\n{\n    %s\n}\n' "$call" > app/Debug.php
    git add app/Debug.php
    output="$(vendor/bin/grumphp git:pre-commit --no-interaction 2>&1 || true)"
    grep -q 'git_blacklist\.\.\. ✘' <<< "$output" || fail "git_blacklist accepted '$call'"
    echo "rejected: $call"
done

step "git_blacklist accepts code that only resembles debug calls"
cat > app/Debug.php <<'PHP'
<?php

namespace App;

use Illuminate\Support\Collection;

class Debug
{
    public function handle(Collection $items): array
    {
        $items->add(1);
        $odd = array_filter([1, 2, 3], fn (int $i): bool => $i % 2 === 1);
        $exitCode = 0;

        return array_values(array_merge($items->all(), $odd, [$exitCode]));
    }
}
PHP
git add app/Debug.php
vendor/bin/grumphp git:pre-commit --no-interaction || fail "commit with no debug calls was rejected"

step "All checks passed"
