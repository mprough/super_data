<?php

declare(strict_types=1);

if (!defined('IS_ADMIN_FLAG') || IS_ADMIN_FLAG !== true) {
    die('Illegal Access');
}

$superDataGroup = $db->Execute(
    "SELECT configuration_group_id
       FROM " . TABLE_CONFIGURATION . "
      WHERE configuration_key = 'PLUGIN_SUPERDATA_VERSION'
      LIMIT 1"
);

if ($superDataGroup->EOF
    || (int)($_GET['gID'] ?? 0) !== (int)$superDataGroup->fields['configuration_group_id']) {
    return;
}
?>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('form[name="configuration"]');
    if (!form) {
        return;
    }

    form.addEventListener('submit', function () {
        const originalFields = form.querySelectorAll('input[type="hidden"][name^="orig_cfg_"]');

        originalFields.forEach(function (originalField) {
            const fieldName = originalField.name.substring(5);
            const groupedName = 'configuration[' + fieldName + ']';
            const controls = Array.from(form.elements).filter(function (control) {
                return control.name === fieldName || control.name === groupedName;
            });

            if (controls.length === 0) {
                return;
            }

            let currentValue = '';
            const selectedControl = controls.find(function (control) {
                return (control.type !== 'radio' && control.type !== 'checkbox') || control.checked;
            });
            if (selectedControl) {
                currentValue = selectedControl.value;
            }

            if (currentValue === originalField.value) {
                controls.forEach(function (control) {
                    control.disabled = true;
                });
                originalField.disabled = true;
            }
        });
    });
});
</script>
