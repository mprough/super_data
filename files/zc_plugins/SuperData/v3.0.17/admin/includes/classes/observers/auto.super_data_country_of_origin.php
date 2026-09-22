<?php

if (!defined('IS_ADMIN_FLAG') || IS_ADMIN_FLAG !== true) {
    die('Illegal Access');
}

class zcObserverSuperDataCountryOfOrigin extends base
{
    public function __construct()
    {
        global $sniffer;

        if (defined('GPSF_PRODUCT_FIELD_COUNTRY_OF_ORIGIN')
            || !$sniffer->field_exists(TABLE_PRODUCTS, 'products_country_of_origin')) {
            return;
        }
        $this->attach($this, [
            'NOTIFY_ADMIN_PRODUCT_COLLECT_INFO_EXTRA_INPUTS',
            'NOTIFY_MODULES_UPDATE_PRODUCT_END',
        ]);
    }

    public function update(&$class, $eventID, $p1, &$p2, &$p3, &$p4)
    {
        if ($eventID === 'NOTIFY_ADMIN_PRODUCT_COLLECT_INFO_EXTRA_INPUTS') {
            $options = [['id' => 0, 'text' => '-- Use store default --']];
            global $db;
            $countries = $db->Execute(
                'SELECT countries_id, countries_name, countries_iso_code_2 FROM ' . TABLE_COUNTRIES . ' ORDER BY countries_name'
            );
            foreach ($countries as $country) {
                $options[] = [
                    'id' => (int)$country['countries_id'],
                    'text' => $country['countries_name'] . ' (' . $country['countries_iso_code_2'] . ')',
                ];
            }
            $p2[] = [
                'label' => ['text' => 'Country of origin', 'field_name' => 'products_country_of_origin'],
                'input' => zen_draw_pull_down_menu(
                    'products_country_of_origin',
                    $options,
                    (int)($p1->products_country_of_origin ?? 0),
                    'class="form-control" id="products_country_of_origin"'
                ),
            ];
        } elseif ($eventID === 'NOTIFY_MODULES_UPDATE_PRODUCT_END') {
            $productsId = (int)($p1['products_id'] ?? 0);
            if ($productsId > 0 && isset($_POST['products_country_of_origin'])) {
                zen_db_perform(
                    TABLE_PRODUCTS,
                    ['products_country_of_origin' => (int)$_POST['products_country_of_origin']],
                    'update',
                    'products_id = ' . $productsId
                );
            }
        }
    }
}
