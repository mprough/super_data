# SuperData 3.0.7

SuperData 3.0.7 replaces the invalid on-page `MerchantCenter` shipping-rate mode with configurable shipping rate tables. Store owners can define up to five destination tables using product weight, displayed price, or item count tiers while retaining the existing Free and FlatRate options.

## Changes since 3.0.6

- Replaced `MerchantCenter` with `RateTables` because Merchant Center is not an on-page shipping-rate calculation mode.
- Added five independently configurable destination shipping tables.
- Added weight, price, and item calculation methods for each table.
- Added a destination country and optional state or region codes to each table.
- Added inclusive upper-limit rate tiers and an optional wildcard tier.
- Added an optional handling charge to each table.
- Added the calculated `shippingRate` to every applicable product Offer.
- Preserved Free and FlatRate as simple shipping-rate modes.
- Added an Offer-level `hasMerchantReturnPolicy` reference to the complete business return policy.
- Kept the full `MerchantReturnPolicy` on the Organization instead of duplicating it in every Offer.
- Formatted POSM attribute Offer prices and monetary shipping values to the configured decimal precision.
- Added the installed SuperData version to the configuration page and admin menu label.
- Added a complete Plugin Manager upgrade path for Zen Cart 2.x.
- Added a complete legacy installer and `upgrade_to_3.0.7.sql` for Zen Cart 1.5.6 and 1.5.7.
- Updated installation, configuration, shipping-table, migration, troubleshooting, and validation documentation.

## Compatibility

- Zen Cart 2.0.x, 2.1.x, and 2.2.x through Plugin Manager.
- Zen Cart 1.5.6 and 1.5.7 through the included legacy installer.

After upgrading, review **Configuration > SuperData**, select the appropriate shipping rate mode, and configure at least one complete RateTables destination when RateTables is selected.
