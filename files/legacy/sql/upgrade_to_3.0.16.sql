# SuperData legacy upgrade to 3.0.16 for Zen Cart 1.5.6 and 1.5.7

UPDATE configuration
SET configuration_value = '3.0.16',
    set_function = 'zen_cfg_select_option(array(\'3.0.16\'),'
WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION';
