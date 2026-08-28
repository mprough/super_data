# SuperData legacy upgrade to 3.0.7 for Zen Cart 1.5.6 and 1.5.7
# Run with Admin > Tools > Install SQL Patches. Change table prefixes there if required.

SET @superdata_group_id := (
    SELECT configuration_group_id
    FROM configuration_group
    WHERE configuration_group_title = 'SuperData'
    ORDER BY configuration_group_id DESC
    LIMIT 1
);

INSERT IGNORE INTO configuration
    (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function)
VALUES
    ('SuperData version', 'PLUGIN_SUPERDATA_VERSION', '3.0.7', 'Installed SuperData version for reference.', @superdata_group_id, 0, 'zen_cfg_select_option(array(\'3.0.7\'),'),
    ('Zone Table calculation method', 'PLUGIN_SUPERDATA_ZONE_TABLE_METHOD', 'weight', 'Used only with ZoneTable. weight uses the product shipping weight, price uses its displayed offer price, and item calculates the rate for one product.', @superdata_group_id, 136, 'zen_cfg_select_option(array(\'weight\', \'price\', \'item\'),'),
    ('Zone Table rates', 'PLUGIN_SUPERDATA_ZONE_TABLE_RATES', '', 'Used only with ZoneTable. Enter upper-limit:rate pairs separated by commas, for example 1:5.95,3:7.95,5:9.95. An optional *:rate pair covers values above the highest tier.', @superdata_group_id, 137, null),
    ('Zone Table handling charge', 'PLUGIN_SUPERDATA_ZONE_TABLE_HANDLING', '0', 'Optional handling charge added to the selected Zone Table rate.', @superdata_group_id, 138, null);

UPDATE configuration
SET configuration_value = '3.0.7',
    set_function = 'zen_cfg_select_option(array(\'3.0.7\'),'
WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION';

UPDATE configuration
SET configuration_value = 'RateTables'
WHERE configuration_key = 'PLUGIN_SUPERDATA_SHIPPING_RATE_MODE'
  AND configuration_value IN ('MerchantCenter', 'ZoneTable');

UPDATE configuration
SET configuration_description = '<strong>RateTables:</strong> Calculate rates for this product from up to five destination tables.<br><strong>Free:</strong> Publish a 0.00 rate only when shipping is genuinely free.<br><strong>FlatRate:</strong> Publish the exact configured charge.',
    set_function = 'zen_cfg_select_option(array(\'RateTables\', \'Free\', \'FlatRate\'),'
WHERE configuration_key = 'PLUGIN_SUPERDATA_SHIPPING_RATE_MODE';

DELETE FROM configuration WHERE configuration_key IN ('PLUGIN_SUPERDATA_ZONE_TABLE_METHOD', 'PLUGIN_SUPERDATA_ZONE_TABLE_RATES', 'PLUGIN_SUPERDATA_ZONE_TABLE_HANDLING');

INSERT IGNORE INTO configuration
    (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function)
SELECT CONCAT('Zone ', z.n, ' ', f.title), CONCAT('PLUGIN_SUPERDATA_ZONE_TABLE_', f.key_part, '_', z.n),
       CASE WHEN f.key_part = 'METHOD' THEN 'weight' WHEN f.key_part = 'COUNTRY' AND z.n = 1 THEN 'US' WHEN f.key_part = 'HANDLING' THEN '0' ELSE '' END,
       f.description, @superdata_group_id, 136 + ((z.n - 1) * 5) + f.offset_value, f.set_function
FROM (SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) z
CROSS JOIN (
    SELECT 'rate type' title, 'METHOD' key_part, 0 offset_value, 'Choose price, weight, or item for this destination table.' description, 'zen_cfg_select_option(array(\'price\', \'weight\', \'item\'),' set_function
    UNION ALL SELECT 'country', 'COUNTRY', 1, 'Two-letter destination country. Leave blank to disable this zone.', null
    UNION ALL SELECT 'regions', 'REGIONS', 2, 'Optional comma-separated state or region codes. Leave blank for the whole country.', null
    UNION ALL SELECT 'rates', 'RATES', 3, 'Inclusive upper-limit:rate pairs, for example 1:5.95,3:7.95,*:9.95.', null
    UNION ALL SELECT 'handling charge', 'HANDLING', 4, 'Optional handling charge added to the selected rate.', null
) f;

UPDATE configuration SET sort_order = 139 WHERE configuration_key = 'PLUGIN_SUPERDATA_HANDLING_MIN_DAYS';
UPDATE configuration SET sort_order = 140 WHERE configuration_key = 'PLUGIN_SUPERDATA_HANDLING_MAX_DAYS';
UPDATE configuration SET sort_order = 141 WHERE configuration_key = 'PLUGIN_SUPERDATA_TRANSIT_MIN_DAYS';
UPDATE configuration SET sort_order = 142 WHERE configuration_key = 'PLUGIN_SUPERDATA_TRANSIT_MAX_DAYS';
