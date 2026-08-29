# SuperData legacy upgrade to 3.0.8 for Zen Cart 1.5.6 and 1.5.7
# Run with Admin > Tools > Install SQL Patches. Change table prefixes there if required.

UPDATE configuration
SET configuration_value = '3.0.8',
    set_function = 'zen_cfg_select_option(array(\'3.0.8\'),' 
WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION';
