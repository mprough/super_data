# SuperData 3.0.16

- Adds Schema.org `countryOfOrigin` to Product JSON-LD when an effective product country is available.
- Reuses Google Product Loader's `gpsf_get_product_country_of_origin()` resolver when installed, so the feed and structured data use one product entry and one store default.
- Falls back safely to the same `products_country_of_origin` field and `GPSF_DEFAULT_COUNTRY_OF_ORIGIN` setting when the helper is unavailable.
- Omits `countryOfOrigin` when no product override or store default is configured.
