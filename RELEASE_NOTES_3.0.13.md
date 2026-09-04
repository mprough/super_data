# SuperData 3.0.13

SuperData 3.0.13 casts Zen Cart's numeric product-price string to a float before rounding it. This prevents the PHP 8 `round()` TypeError introduced in 3.0.12 when Product price tax mode is set to `Never` or tax is otherwise not added.

The correction is included in both the Plugin Manager and legacy storefront files. The three tax modes and their behavior remain unchanged.
