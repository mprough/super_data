# SuperData 3.0.8

SuperData 3.0.8 keeps structured Offer data consistent and prevents PHP floating-point precision artifacts from appearing in product prices.

## Fixes

- Retains `shippingDetails` for in-stock and out-of-stock products.
- Retains the configured shipping destination and delivery timing when a product falls outside all rate-table tiers.
- Omits only `shippingRate` when no truthful rate can be calculated.
- Normalizes simple-product Offer prices to the configured decimal places.
- Normalizes attribute Offer prices and AggregateOffer low and high prices.
- Applies the fixes to both the encapsulated Plugin Manager package and the legacy storefront file.
- Reduces Zen Cart 2.2.2 Save All requests by excluding unchanged SuperData fields before submission, preventing oversized configuration POSTs from triggering server security limits.
