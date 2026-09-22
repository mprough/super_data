<?php

if (!defined('IS_ADMIN_FLAG') || IS_ADMIN_FLAG !== true) {
    die('Illegal Access');
}
/**
 * SuperData admin menu language definition for Zen Cart 1.5.6/1.5.7.
 *
 * @license GNU General Public License v2.0
 */
if (!defined('IS_ADMIN_FLAG')) {
    die('Illegal Access');
}

define('BOX_CONFIGURATION_SUPER_DATA', 'SuperData v3.0.17');

if (!function_exists('superdata_cfg_pull_down_country_of_origin')) {
    function superdata_cfg_pull_down_country_of_origin($countriesId, $key = ''): string
    {
        global $db;
        $name = $key !== '' ? "configuration[$key]" : 'configuration_value';
        if (defined('GPSF_DEFAULT_COUNTRY_OF_ORIGIN')) {
            return zen_draw_hidden_field($name, (int)$countriesId) .
                '<span class="label label-info">Managed by Google Product Loader</span>';
        }
        $options = [['id' => 0, 'text' => '-- Not specified --']];
        $countries = $db->Execute(
            'SELECT countries_id, countries_name, countries_iso_code_2 FROM ' . TABLE_COUNTRIES . ' ORDER BY countries_name'
        );
        foreach ($countries as $country) {
            $options[] = [
                'id' => (int)$country['countries_id'],
                'text' => $country['countries_name'] . ' (' . $country['countries_iso_code_2'] . ')',
            ];
        }
        return zen_draw_pull_down_menu($name, $options, (int)$countriesId);
    }
}
