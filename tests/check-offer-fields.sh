#!/usr/bin/env bash
set -euo pipefail

modern='files/zc_plugins/SuperData/v3.0.17/catalog/includes/templates/default/jscript/super_data_jscript.php'
legacy='files/legacy/includes/templates/YOUR_TEMPLATE/jscript/jscript_super_data.php'

for file in "$modern" "$legacy"; do
    grep -Fq "\$title = !empty(META_TAG_TITLE) ? META_TAG_TITLE : '';" "$file"
    grep -Fq "['validFrom']" "$file"
    grep -Fq "if (\$page_type === 'product'" "$file"
    grep -Fq '&& isset($product_date_added)' "$file"
    grep -Fq "['shippingDetails']" "$file"
    grep -Fq "'@type' => 'OfferShippingDetails'" "$file"
    grep -Fq "'@type' => 'ShippingDeliveryTime'" "$file"
    grep -Fq "\$shippingRateMode === 'Free'" "$file"
    grep -Fq "\$shippingRateMode === 'FlatRate'" "$file"
    grep -Fq 'preg_replace' "$file"
    grep -Fq '(float)$shippingRateValue >= 0' "$file"
    grep -Fq "\$shippingRateMode === 'RateTables'" "$file"
    grep -Fq 'sdata_zone_table_rate(' "$file"
    grep -Fq 'if ($zoneRate !== null)' "$file"
    grep -Fq '$product_always_free_shipping' "$file"
    grep -Fq '$weight = 0.0;' "$file"
    grep -Fq 'function sdata_decimal_value(' "$file"
    grep -Fq "'value' => sdata_decimal_value(\$weight)" "$file"
    test "$(grep -Fc "'value' => sdata_decimal_value(" "$file")" -eq 2
    grep -Fq '? 0.0' "$file"
    grep -Fq "'price' => number_format((float)\$product_base_displayed_price" "$file"
    grep -Fq "PLUGIN_SUPERDATA_ZONE_TABLE_RATES_" "$file"
    grep -Fq 'function sdata_get_product_country_of_origin(' "$file"
    grep -Fq "function_exists('gpsf_get_product_country_of_origin')" "$file"
    grep -Fq "'products_country_of_origin'" "$file"
    grep -Fq "GPSF_DEFAULT_COUNTRY_OF_ORIGIN" "$file"
    grep -Fq "PLUGIN_SUPERDATA_COUNTRY_OF_ORIGIN_DEFAULT" "$file"
    grep -Fq "['countryOfOrigin']" "$file"
    grep -Fq "'@type' => 'Country'" "$file"
    grep -Fq "\$schema['image']" "$file"
    grep -Fq "PLUGIN_SUPERDATA_LOGO" "$file"
    grep -Fq "'hasMerchantReturnPolicy' =>" "$file"
    grep -Fq "'/#merchant-return-policy'" "$file"
    grep -Fq "\$offerEnhancements['hasMerchantReturnPolicy']" "$file"
    grep -Fq "PLUGIN_SUPERDATA_RETURNS_APPLICABLE_COUNTRY" "$file"
    grep -Fq "['refundType']" "$file"
    grep -Fq "['returnShippingFeesAmount']" "$file"
    grep -Fq '&& (float)$rFeeNumeric > 0)' "$file"
    test "$(grep -Fc 'array_merge($schema, $hasMerchantReturnPolicy)' "$file")" -eq 1

    if grep -Fq 'array_merge($offer, $hasMerchantReturnPolicy)' "$file"; then
        echo "Store-wide return policy must not be duplicated under Offer in $file." >&2
        exit 1
    fi

    test "$(grep -Fc 'array_merge($offer, $offerEnhancements)' "$file")" -eq 3
done

if rg -n "MerchantCenter" README.md files/legacy/sql/install.sql files/legacy/includes \
    files/zc_plugins/SuperData/v3.0.17/catalog; then
    echo 'MerchantCenter must not be an active SuperData shipping rate mode.' >&2
    exit 1
fi

for storefront in "$modern" "$legacy"; do
    grep -Fq "PLUGIN_SUPERDATA_PRODUCT_PRICE_TAX_MODE" "$storefront"
    grep -Fq "!empty(\$_SESSION['customer_id'])" "$storefront"
    grep -Fq '(float)zen_get_products_actual_price($product_id)' "$storefront"
    grep -Fq '$product_priced_by_attributes = zen_get_products_price_is_priced_by_attributes($product_id);' "$storefront"
    grep -Fq 'zen_get_attributes_price_final(' "$storefront"
    grep -Fq "['availabilityStarts']" "$storefront"
    test "$(grep -Fc '&& $backPreOrderDate' "$storefront")" -eq 3

    if grep -Fq "['availability_date']" "$storefront"; then
        echo "Unrecognized availability_date property remains in $storefront." >&2
        exit 1
    fi

    if grep -Fq "? \$attribute['options_values_price']" "$storefront"; then
        echo "Raw attribute components must not be published as complete offer prices in $storefront." >&2
        exit 1
    fi
done

if grep -Eq 'str_(contains|starts_with|ends_with)|\bfn[[:space:]]*\(|:[[:space:]]*mixed' "$legacy"; then
    echo 'Legacy build contains PHP 8-only syntax or functions.' >&2
    exit 1
fi
