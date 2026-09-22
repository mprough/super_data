# SuperData legacy upgrade to 3.0.17 for Zen Cart 1.5.6 and 1.5.7

INSERT IGNORE INTO configuration
    (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function)
SELECT 'Default Product Country of Origin', 'PLUGIN_SUPERDATA_COUNTRY_OF_ORIGIN_DEFAULT', '0',
       'Standalone fallback used when Google Product Loader is not installed and the product is set to Use store default.',
       configuration_group_id, 291, 'superdata_cfg_pull_down_country_of_origin('
FROM configuration
WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION'
LIMIT 1;

UPDATE configuration
SET configuration_value = '3.0.17',
    set_function = 'zen_cfg_select_option(array(\'3.0.17\'),'
WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION';
