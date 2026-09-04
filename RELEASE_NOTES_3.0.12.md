# SuperData 3.0.12

SuperData 3.0.12 fixes product prices that were always increased by Zen Cart's resolved tax rate. A new Product price tax mode applies consistently to Schema and Open Graph output, with `Never` as the safe default, `Always` for the visitor's resolved rate, and `LoggedInTaxZone` for tax only when a customer is logged in and Zen Cart resolves the customer's configured tax zone.

Both the Plugin Manager and legacy editions include the setting and runtime fix. Existing settings are preserved during upgrade, and no state or tax percentage is hard-coded.
