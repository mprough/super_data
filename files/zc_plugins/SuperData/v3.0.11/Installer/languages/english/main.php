<?php

declare(strict_types=1);

if (!defined('IS_ADMIN_FLAG')) {
    die('Illegal Access');
}

/**
 * @author: torvista
 * @link: https://github.com/torvista/Zen_Cart-Structured_Data
 * @license https://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version torvista 08 Feb 2025
 */
define('ERROR_SUPERDATA_CONFLICTING_FILE', 'SuperData did not alter the existing Structured Data file at %s. Rename or remove that file after making a backup, then run the installation again.');
