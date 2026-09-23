# SuperData configuration reference

Current source: SuperData **3.0.17**. Settings appear under **Admin > Configuration > SuperData**. This is a list of the settings installed by the current Plugin Manager package, in admin sort order. Blank defaults are shown as `empty`. Your store's saved values are not overwritten by this reference.

The source of truth is [`files/zc_plugins/SuperData/v3.0.17/Installer/ScriptedInstaller.php`](../files/zc_plugins/SuperData/v3.0.17/Installer/ScriptedInstaller.php), specifically the initial `INSERT IGNORE INTO configuration` block. The legacy installer is [`files/legacy/sql/install.sql`](../files/legacy/sql/install.sql). The latter currently omits the 25 settings for shipping zones 1–5; those are listed below as **Plugin Manager only**. Later migration and upgrade statements in the scripted installer update existing installations and are not additional settings.

When releasing a new version, compare both installers' `configuration_key`, title, default, sort order, descriptions, and choices; update this page and the version above. Check settings added through upgrade SQL as well. Keep differences between installation methods explicit. This document records installation defaults, not a recommended configuration for every store.

## Core

| Admin label | Configuration key | Install default |
| --- | --- | --- |
| SuperData version | `PLUGIN_SUPERDATA_VERSION` | `3.0.17` |
| Enable SuperData generation | `PLUGIN_SUPERDATA_ENABLE` | `true` |
| Enable Schema markup | `PLUGIN_SUPERDATA_SCHEMA_ENABLE` | `true` |
| Enable Facebook-Open Graph markup | `PLUGIN_SUPERDATA_FOG_ENABLE` | `true` |
| Enable Twitter Card markup | `PLUGIN_SUPERDATA_TWITTER_CARD_ENABLE` | `true` |

## Facebook settings

| Admin label | Configuration key | Install default |
| --- | --- | --- |
| Facebook Application ID | `PLUGIN_SUPERDATA_FOG_APPID` | `empty` |
| Facebook Admin ID (optional) | `PLUGIN_SUPERDATA_FOG_ADMINID` | `empty` |
| Facebook Page (optional) | `PLUGIN_SUPERDATA_FOG_PAGE` | `empty` |

## Business identity and contact

| Admin label | Configuration key | Install default |
| --- | --- | --- |
| Organization Type | `PLUGIN_SUPERDATA_ORGANIZATION_TYPE` | `Organization` |
| LocalBusiness Type | `PLUGIN_SUPERDATA_LOCAL_BUSINESS_TYPE` | `Store` |
| Legal Name (Schema, optional) | `PLUGIN_SUPERDATA_LEGAL_NAME` | `empty` |
| Dun & Bradstreet DUNS number (Schema, optional) | `PLUGIN_SUPERDATA_DUNS` | `empty` |
| Name (Schema) | `PLUGIN_SUPERDATA_LOCAL_BUSINESS_NAME` | `empty` |
| Short Description (Schema) | `PLUGIN_SUPERDATA_DESCRIPTION` | `empty` |
| Business Image (Schema, optional) | `PLUGIN_SUPERDATA_PROPERTY_IMAGE` | `empty` |
| Logo (Schema) | `PLUGIN_SUPERDATA_LOGO` | `empty` |
| Price Range (Schema) | `PLUGIN_SUPERDATA_PRICE_RANGE` | `empty` |
| Street Address (Schema/OG) | `PLUGIN_SUPERDATA_STREET_ADDRESS` | `empty` |
| City (Schema/OG) | `PLUGIN_SUPERDATA_LOCALITY` | `empty` |
| State (Schema/OG) | `PLUGIN_SUPERDATA_REGION` | `empty` |
| Postal Code (Schema/OG) | `PLUGIN_SUPERDATA_POSTALCODE` | `empty` |
| Country (Schema/OG) | `PLUGIN_SUPERDATA_COUNTRYNAME` | `empty` |
| Email (Schema, optional) | `PLUGIN_SUPERDATA_EMAIL` | `empty` |
| Telephone (Schema) | `PLUGIN_SUPERDATA_TELEPHONE` | `empty` |
| Fax (Schema, optional) | `PLUGIN_SUPERDATA_FAX` | `empty` |
| Available Languages (Schema, optional) | `PLUGIN_SUPERDATA_AVAILABLE_LANGUAGE` | `empty` |
| Locales (OG) | `PLUGIN_SUPERDATA_FOG_LOCALES` | `empty` |
| Area Served (Schema-Customer Service, optional) | `PLUGIN_SUPERDATA_AREA_SERVED` | `empty` |
| Hours Available (Schema-Customer Service, optional) | `PLUGIN_SUPERDATA_HOURS` | `empty` |
| Accepted Payment Methods (Schema) | `PLUGIN_SUPERDATA_ACCEPTED_PAYMENT_METHODS` | `ByBankTransferInAdvance, ByInvoice, Cash, CheckInAdvance, COD, DirectDebit, GoogleCheckout, PayPal, PaySwarm, AmericanExpress, DinersClub, Discover, JCB, MasterCard, VISA` |
| Tax ID (Schema, optional) | `PLUGIN_SUPERDATA_TAXID` | `empty` |
| VAT Number (Schema, optional) | `PLUGIN_SUPERDATA_VATID` | `empty` |
| Profile/Social Pages (Schema-sameAs, optional) | `PLUGIN_SUPERDATA_SAMEAS` | `empty` |
| Product Shipping Area (Schema, optional) | `PLUGIN_SUPERDATA_ELIGIBLE_REGION` | `empty` |

## Product and offer

| Admin label | Configuration key | Install default |
| --- | --- | --- |
| Currency (Schema/OG) | `PLUGIN_SUPERDATA_PRICE_CURRENCY` | `empty` |
| Product price tax mode | `PLUGIN_SUPERDATA_PRODUCT_PRICE_TAX_MODE` | `Never` |
| Product Delivery Time when in stock (Schema) | `PLUGIN_SUPERDATA_DELIVERYLEADTIME` | `empty` |
| Product Delivery Time when out of stock (Schema) | `PLUGIN_SUPERDATA_DELIVERYLEADTIME_OOS` | `empty` |
| Offer validFrom | `PLUGIN_SUPERDATA_VALID_FROM_ENABLE` | `true` |

## Shipping

| Admin label | Configuration key | Install default |
| --- | --- | --- |
| Offer shippingDetails | `PLUGIN_SUPERDATA_SHIPPING_DETAILS_ENABLE` | `true` |
| Shipping rate mode | `PLUGIN_SUPERDATA_SHIPPING_RATE_MODE` | `RateTables` |
| Shipping destination country | `PLUGIN_SUPERDATA_SHIPPING_COUNTRY` | `US` |
| Shipping flat rate | `PLUGIN_SUPERDATA_SHIPPING_RATE` | `empty` |
| Zone 1 rate type (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_METHOD_1` | `weight` |
| Zone 1 country (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_COUNTRY_1` | `US` |
| Zone 1 regions (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_REGIONS_1` | `empty` |
| Zone 1 rates (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_RATES_1` | `empty` |
| Zone 1 handling charge (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_HANDLING_1` | `0` |
| Zone 2 rate type (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_METHOD_2` | `weight` |
| Zone 2 country (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_COUNTRY_2` | `empty` |
| Zone 2 regions (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_REGIONS_2` | `empty` |
| Zone 2 rates (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_RATES_2` | `empty` |
| Zone 2 handling charge (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_HANDLING_2` | `0` |
| Zone 3 rate type (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_METHOD_3` | `weight` |
| Zone 3 country (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_COUNTRY_3` | `empty` |
| Zone 3 regions (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_REGIONS_3` | `empty` |
| Zone 3 rates (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_RATES_3` | `empty` |
| Zone 3 handling charge (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_HANDLING_3` | `0` |
| Zone 4 rate type (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_METHOD_4` | `weight` |
| Zone 4 country (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_COUNTRY_4` | `empty` |
| Zone 4 regions (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_REGIONS_4` | `empty` |
| Zone 4 rates (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_RATES_4` | `empty` |
| Zone 4 handling charge (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_HANDLING_4` | `0` |
| Zone 5 rate type (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_METHOD_5` | `weight` |
| Zone 5 country (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_COUNTRY_5` | `empty` |
| Zone 5 regions (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_REGIONS_5` | `empty` |
| Zone 5 rates (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_RATES_5` | `empty` |
| Zone 5 handling charge (Plugin Manager only) | `PLUGIN_SUPERDATA_ZONE_TABLE_HANDLING_5` | `0` |
| Shipping handling time minimum | `PLUGIN_SUPERDATA_HANDLING_MIN_DAYS` | `0` |
| Shipping handling time maximum | `PLUGIN_SUPERDATA_HANDLING_MAX_DAYS` | `1` |
| Shipping transit time minimum | `PLUGIN_SUPERDATA_TRANSIT_MIN_DAYS` | `2` |

## Product, stock, and reviews

| Admin label | Configuration key | Install default |
| --- | --- | --- |
| Shipping transit time maximum | `PLUGIN_SUPERDATA_TRANSIT_MAX_DAYS` | `7` |
| Product Condition (Schema/OG) | `PLUGIN_SUPERDATA_FOG_PRODUCT_CONDITION` | `new` |
| Default Product Weight | `PLUGIN_SUPERDATA_DEFAULT_WEIGHT` | `0.5` |
| Out of Stock Status | `PLUGIN_SUPERDATA_OOS_DEFAULT` | `BackOrder` |
| Out of Stock - BackOrder/PreOrder Date | `PLUGIN_SUPERDATA_OOS_AVAILABILITY_DELAY` | `10` |
| Limit - Product Name | `PLUGIN_SUPERDATA_MAX_NAME` | `150` |
| Limit - Product Description | `PLUGIN_SUPERDATA_MAX_DESCRIPTION` | `5000` |
| Reviews - Default Review Date | `PLUGIN_SUPERDATA_REVIEW_DEFAULT_DATE` | `2020-09-23 13:48:39` |
| No Review - Add One? | `PLUGIN_SUPERDATA_REVIEW_USE_DEFAULT` | `true` |
| No Review - Average Rating | `PLUGIN_SUPERDATA_REVIEW_DEFAULT_VALUE` | `4` |

## Returns

| Admin label | Configuration key | Install default |
| --- | --- | --- |
| Returns - Policy | `PLUGIN_SUPERDATA_RETURNS_POLICY` | `Finite` |
| Returns - Days | `PLUGIN_SUPERDATA_RETURNS_DAYS` | `14` |
| Returns - Methods | `PLUGIN_SUPERDATA_RETURNS_METHOD` | `Mail` |
| Returns - Type | `PLUGIN_SUPERDATA_RETURNS_TYPE` | `FreeReturn` |
| Returns - Refund Type | `PLUGIN_SUPERDATA_RETURNS_REFUND_TYPE` | `FullRefund` |
| Returns - Fee | `PLUGIN_SUPERDATA_RETURNS_FEE` | `0` |
| Returns - Applicable Country | `PLUGIN_SUPERDATA_RETURNS_APPLICABLE_COUNTRY` | `empty` |
| Returns - Return Destination Country | `PLUGIN_SUPERDATA_RETURNS_POLICY_COUNTRY` | `empty` |

## Custom fields and country of origin

| Admin label | Configuration key | Install default |
| --- | --- | --- |
| Custom Product Field - Google Product Category | `PLUGIN_SUPERDATA_GPC_FIELD` | `products_google_product_category` |
| Custom Product Field - GTIN | `PLUGIN_SUPERDATA_GTIN_FIELD` | `products_gtin` |
| Default Product Country of Origin | `PLUGIN_SUPERDATA_COUNTRY_OF_ORIGIN_DEFAULT` | `0` |
| Custom POS Field - GTIN | `PLUGIN_SUPERDATA_POS_GTIN_FIELD` | `pos_gtin` |
| Custom POS Field - MPN | `PLUGIN_SUPERDATA_POS_MPN_FIELD` | `pos_mpn` |

## Social images and metadata

| Admin label | Configuration key | Install default |
| --- | --- | --- |
| Facebook Default Image: Product (optional) | `PLUGIN_SUPERDATA_FOG_DEFAULT_PRODUCT_IMAGE` | `empty` |
| Facebook Default Image: non Product (optional) | `PLUGIN_SUPERDATA_FOG_DEFAULT_IMAGE` | `empty` |
| Facebook Type - Non Product Page | `PLUGIN_SUPERDATA_FOG_TYPE_SITE` | `business.business` |
| Facebook Type - Product Page | `PLUGIN_SUPERDATA_FOG_TYPE_PRODUCT` | `product` |
| Twitter Default Image (optional) | `PLUGIN_SUPERDATA_TWITTER_DEFAULT_IMAGE` | `empty` |
| Twitter Username | `PLUGIN_SUPERDATA_TWITTER_USERNAME` | `empty` |
| Twitter Page URL | `PLUGIN_SUPERDATA_TWITTER_PAGE` | `empty` |
| Google - Default Product Category | `PLUGIN_SUPERDATA_GOOGLE_PRODUCT_CATEGORY` | `empty` |
