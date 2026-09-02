# SuperData 3.0.11

SuperData 3.0.11 initializes the product weight before page-type detection. This prevents an undefined-variable PHP warning when rate-table shipping is enabled and SuperData runs on category or other non-product pages.

The correction is included in both the Zen Cart Plugin Manager and legacy storefront files.
