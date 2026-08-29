<?php

declare(strict_types=1);

if (!defined('IS_ADMIN_FLAG')) {
    die('Illegal Access');
}

/**
 * @author PRO-Webs.net
 * @link https://pro-webs.net/
 * @contributors torvista, Zen4All, ZenExpert
 * @license https://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version ZenExpert 19 Dec 2025
 */
return [
    'pluginVersion' => 'v3.0.8',
    'pluginName' => 'SuperData',
    'pluginDescription' => 'Modern JSON-LD, Open Graph, and social metadata for Zen Cart.',
    'pluginAuthor' => 'PRO-Webs.net, torvista, Zen4All, ZenExpert',
    'pluginId' => 1984, // Super Data Markup ID in the Zen Cart Plugins Library
    'zcVersions' => ['v200', 'v210', 'v220'],
    'changelog' => 'https://github.com/mprough/super_data',
    'github_repo' => 'https://github.com/mprough/super_data',
    'pluginGroups' => [],
];
