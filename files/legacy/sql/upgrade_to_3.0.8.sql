# SuperData legacy upgrade to 3.0.8 for Zen Cart 1.5.6 and 1.5.7
# Run with Admin > Tools > Install SQL Patches. Change table prefixes there if required.

UPDATE configuration
SET configuration_value = '3.0.8',
    set_function = 'zen_cfg_select_option(array(\'3.0.8\'),',
    configuration_description = 'Installed version. Check <a href="https://github.com/mprough/super_data" target="_blank" rel="noopener">SuperData on GitHub</a> for the newest release because GitHub updates can appear before Zen Cart Plugin Library approval is complete.'
WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION';
