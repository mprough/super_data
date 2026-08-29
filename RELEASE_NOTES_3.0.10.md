# SuperData 3.0.10

SuperData 3.0.10 corrects structured shipping rates for products marked Always Free Shipping in Zen Cart.

## Fixes

- Detects `product_is_always_free_shipping` on product pages.
- Publishes a `0.00` shipping rate for each applicable configured destination.
- Prevents flat-rate and rate-table charges from being applied to Always Free Shipping products.
- Applies the correction to Plugin Manager and legacy storefront files.
