# SuperData legacy upgrade to 3.0.9 for Zen Cart 1.5.6 and 1.5.7
# Run with Admin > Tools > Install SQL Patches. Change table prefixes there if required.

UPDATE configuration
SET configuration_value = '3.0.9',
    set_function = 'zen_cfg_select_option(array(\'3.0.9\'),'
WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION';

DELETE FROM configuration WHERE configuration_key = 'PLUGIN_SUPERDATA_GOOGLE_PUBLISHER';

UPDATE configuration SET sort_order = 161 WHERE configuration_key = 'PLUGIN_SUPERDATA_HANDLING_MIN_DAYS';
UPDATE configuration SET sort_order = 162 WHERE configuration_key = 'PLUGIN_SUPERDATA_HANDLING_MAX_DAYS';
UPDATE configuration SET sort_order = 163 WHERE configuration_key = 'PLUGIN_SUPERDATA_TRANSIT_MIN_DAYS';
UPDATE configuration SET sort_order = 164 WHERE configuration_key = 'PLUGIN_SUPERDATA_TRANSIT_MAX_DAYS';
UPDATE configuration SET sort_order = 165 WHERE configuration_key = 'PLUGIN_SUPERDATA_FOG_PRODUCT_CONDITION';
UPDATE configuration SET sort_order = 166 WHERE configuration_key = 'PLUGIN_SUPERDATA_DEFAULT_WEIGHT';
UPDATE configuration SET sort_order = 167 WHERE configuration_key = 'PLUGIN_SUPERDATA_OOS_DEFAULT';
UPDATE configuration SET sort_order = 168 WHERE configuration_key = 'PLUGIN_SUPERDATA_OOS_AVAILABILITY_DELAY';

UPDATE configuration
SET sort_order = 136 + ((CAST(SUBSTRING_INDEX(configuration_key, '_', -1) AS UNSIGNED) - 1) * 5)
WHERE configuration_key LIKE 'PLUGIN_SUPERDATA_ZONE_TABLE_METHOD_%';
UPDATE configuration
SET sort_order = 137 + ((CAST(SUBSTRING_INDEX(configuration_key, '_', -1) AS UNSIGNED) - 1) * 5)
WHERE configuration_key LIKE 'PLUGIN_SUPERDATA_ZONE_TABLE_COUNTRY_%';
UPDATE configuration
SET sort_order = 138 + ((CAST(SUBSTRING_INDEX(configuration_key, '_', -1) AS UNSIGNED) - 1) * 5)
WHERE configuration_key LIKE 'PLUGIN_SUPERDATA_ZONE_TABLE_REGIONS_%';
UPDATE configuration
SET sort_order = 139 + ((CAST(SUBSTRING_INDEX(configuration_key, '_', -1) AS UNSIGNED) - 1) * 5)
WHERE configuration_key LIKE 'PLUGIN_SUPERDATA_ZONE_TABLE_RATES_%';
UPDATE configuration
SET sort_order = 140 + ((CAST(SUBSTRING_INDEX(configuration_key, '_', -1) AS UNSIGNED) - 1) * 5)
WHERE configuration_key LIKE 'PLUGIN_SUPERDATA_ZONE_TABLE_HANDLING_%';
