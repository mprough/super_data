# SuperData legacy upgrade to 3.0.5
# Run with Admin > Tools > Install SQL Patches.
# Existing configuration values are preserved.

UPDATE configuration
SET configuration_description = 'Add OfferShippingDetails to every product Offer using the configured destination and delivery times. Disable only when no product shipping information should be published.'
WHERE configuration_key = 'PLUGIN_SUPERDATA_SHIPPING_DETAILS_ENABLE';

UPDATE configuration
SET configuration_description = '<strong>ZoneTable:</strong> Calculate the rate from manual tiers.<br><strong>Free:</strong> Publish a 0.00 rate only when shipping is genuinely free.<br><strong>FlatRate:</strong> Publish the exact configured charge for every covered product.'
WHERE configuration_key = 'PLUGIN_SUPERDATA_SHIPPING_RATE_MODE';
