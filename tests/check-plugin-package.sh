#!/usr/bin/env bash
set -euo pipefail

version_dir='files/zc_plugins/SuperData/v3.0.7'

required=(
    'README.md'
    'LICENSE'
    "$version_dir/manifest.php"
    "$version_dir/Installer/ScriptedInstaller.php"
    "$version_dir/Installer/languages/english/main.php"
    "$version_dir/admin/includes/extra_datafiles/super_data_menu_name.php"
    "$version_dir/catalog/includes/classes/observers/auto.super_data.php"
    "$version_dir/catalog/includes/templates/default/jscript/super_data_jscript.php"
    'files/legacy/YOUR_ADMIN/includes/extra_datafiles/super_data.php'
    'files/legacy/includes/templates/YOUR_TEMPLATE/jscript/jscript_super_data.php'
    'files/legacy/sql/install.sql'
    'files/legacy/sql/upgrade_to_3.0.7.sql'
    'files/legacy/sql/uninstall.sql'
)

for file in "${required[@]}"; do
    test -f "$file" || { echo "Missing required package file: $file" >&2; exit 1; }
done

manifest="$version_dir/manifest.php"
grep -Fq "'pluginVersion' => 'v3.0.7'" "$manifest"
grep -Fq "'pluginName' => 'SuperData'" "$manifest"
grep -Fq "'pluginId' => 1984" "$manifest"
grep -Fq "'zcVersions' => ['v200', 'v210', 'v220']" "$manifest"
grep -Fq "'github_repo' => 'https://github.com/mprough/super_data'" "$manifest"

installer="$version_dir/Installer/ScriptedInstaller.php"
grep -Fq 'class ScriptedInstaller extends ScriptedInstallBase' "$installer"
grep -Fq 'protected function executeInstall()' "$installer"
grep -Fq 'protected function executeUpgrade(...$args): bool' "$installer"
grep -Fq "defined('PLUGIN_SUPERDATA_VERSION')" "$installer"
grep -Fq 'protected function executeUninstall()' "$installer"
grep -Fq 'executeInstallerSql(' "$installer"
grep -Fq "'PLUGIN_SUPERDATA_VERSION', '3.0.7'" "$installer"
grep -Fq "array(\'RateTables\', \'Free\', \'FlatRate\')" "$installer"
grep -Fq "define('BOX_CONFIGURATION_SUPER_DATA', 'SuperData v3.0.7')" \
    "$version_dir/admin/includes/extra_datafiles/super_data_menu_name.php"
grep -Fq "define('BOX_CONFIGURATION_SUPER_DATA', 'SuperData v3.0.7')" \
    'files/legacy/YOUR_ADMIN/includes/extra_datafiles/super_data.php'

observer="$version_dir/catalog/includes/classes/observers/auto.super_data.php"
if grep -Fq 'Zencart\\DbRepositories\\PluginControlRepository' "$observer"; then
    echo 'Observer must not depend on PluginControlRepository; it is unavailable in supported Zen Cart 2.0.x stores.' >&2
    exit 1
fi
grep -Fq 'dirname(__DIR__, 3)' "$observer"

if grep -Eq '\b(unlink|rmdir)\s*\(' "$installer"; then
    echo 'Installer must not automatically delete existing store files.' >&2
    exit 1
fi

for file in $(find "$version_dir" -type f -name '*.php' ! -name 'manifest.php'); do
    grep -Fq "defined('IS_ADMIN_FLAG')" "$file" || {
        echo "Missing direct-access guard: $file" >&2
        exit 1
    }
done

if grep -REin '(FROM|INTO|UPDATE|TABLE)[[:space:]]+zen_[A-Za-z0-9_]+' files/legacy/sql; then
    echo 'Legacy SQL must not hard-code the zen_ database prefix.' >&2
    exit 1
fi

grep -Fq '## Install on Zen Cart 2.x' README.md
grep -Fq '## Install on Zen Cart 1.5.6 or 1.5.7' README.md
grep -Fq '## Stores with Google Product Search Feeder or Google Merchant Center Feeder' README.md
grep -Fq '## Uninstall and rollback' README.md
grep -Fq '## Project history' README.md
grep -Fq '## License and warranty' README.md
