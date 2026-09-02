#!/usr/bin/env bash
set -euo pipefail

modern='files/zc_plugins/SuperData/v3.0.11/catalog/includes/templates/default/jscript/super_data_jscript.php'
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
    grep -Fq '? 0.0' "$file"
    grep -Fq "'price' => number_format((float)\$product_base_displayed_price" "$file"
    grep -Fq "PLUGIN_SUPERDATA_ZONE_TABLE_RATES_" "$file"
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
    files/zc_plugins/SuperData/v3.0.11/catalog; then
    echo 'MerchantCenter must not be an active SuperData shipping rate mode.' >&2
    exit 1
fi

if grep -Eq 'str_(contains|starts_with|ends_with)|\bfn[[:space:]]*\(|:[[:space:]]*mixed' "$legacy"; then
    echo 'Legacy build contains PHP 8-only syntax or functions.' >&2
    exit 1
fi
