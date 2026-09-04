# SuperData legacy upgrade to 3.0.13 for Zen Cart 1.5.6 and 1.5.7
# Run with Admin > Tools > Install SQL Patches. Change table prefixes there if required.

UPDATE configuration
SET configuration_value = '3.0.13',
    set_function = 'zen_cfg_select_option(array(\'3.0.13\'),'
WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION';

INSERT IGNORE INTO configuration
    (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function)
SELECT
    'Product price tax mode',
    'PLUGIN_SUPERDATA_PRODUCT_PRICE_TAX_MODE',
    'Never',
    '<strong>Never:</strong> Publish product prices without tax.<br><strong>Always:</strong> Add the tax rate Zen Cart resolves for the visitor.<br><strong>LoggedInTaxZone:</strong> Add tax only for a logged-in customer when Zen Cart resolves a tax rate for that customer''s country and zone.',
    configuration_group_id,
    121,
    'zen_cfg_select_option(array(\'Never\', \'Always\', \'LoggedInTaxZone\'),' 
FROM configuration
WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION'
LIMIT 1;
