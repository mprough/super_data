# SuperData for Zen Cart

SuperData adds modern, Google-ready structured data to Zen Cart. It generates Product and Offer JSON-LD, business identity markup, breadcrumbs, Facebook Open Graph metadata, and Twitter Cards without changing the visible product page.

Current version: **3.0.4**

SuperData is the modern continuation of a project whose roots reach back to the original **Super Data Markup** plugin. Version 3 brings that history together in one maintained package for current and legacy Zen Cart stores.

## What SuperData generates

Depending on the page and enabled settings, SuperData can generate:

- `Organization`, `OnlineBusiness`, or `LocalBusiness`
- `WebSite` and page information
- `BreadcrumbList`
- `Product`
- `Offer` or `AggregateOffer`
- product reviews and aggregate ratings
- `OfferShippingDetails`
- `MerchantReturnPolicy`
- Facebook Open Graph metadata
- Twitter Card metadata

SuperData supports simple products, products priced by attributes, attribute price ranges, and Products' Options' Stock Manager offers.

## Version 3 highlights

- One consistent enhancement path for every supported Offer type
- `validFrom` on every Offer when enabled
- `shippingDetails` with destination and delivery timing
- Merchant Center, free-shipping, and exact flat-rate modes
- `hasMerchantReturnPolicy` on the business and every Offer
- configurable `refundType`
- business `image` with automatic logo fallback
- two-decimal Offer prices
- Plugin Manager package for Zen Cart 2.x
- traditional files and SQL installer for legacy Zen Cart
- migration of matching values from former `PLUGIN_SDATA_*` settings
- automated PHP compatibility and required-field checks

## Compatibility

| Package | Zen Cart | PHP | Installation method |
| --- | --- | --- | --- |
| Plugin Manager | 2.0.x, 2.1.x, 2.2.x | 7.4 through 8.5 | Admin > Modules > Plugin Manager |
| Legacy | 1.5.6, 1.5.7 | 7.3 through 8.5 | Template files and SQL patch |

The Plugin Manager manifest declares the Zen Cart 2.0, 2.1, and 2.2 families. The legacy edition deliberately avoids PHP 8-only syntax and functions.

Always test on a development copy first. Back up the store files and database before installing, upgrading, or removing any plugin.

## Package layout

```text
files/
|-- legacy/
|   |-- YOUR_ADMIN/
|   |-- includes/templates/YOUR_TEMPLATE/
|   `-- sql/
`-- zc_plugins/
    `-- SuperData/v3.0.4/
```

- Use `files/zc_plugins` for Zen Cart 2.x.
- Use `files/legacy` for Zen Cart 1.5.6 or 1.5.7.
- Do not install both editions on one store.

## Install on Zen Cart 2.x

1. Back up the store files and database.
2. Copy the contents of `files/zc_plugins` into the store's existing `zc_plugins` directory.
3. Sign in to Zen Cart Admin.
4. Open **Modules > Plugin Manager**.
5. Locate **SuperData 3.0.4** and select **Install**.
6. Open **Configuration > SuperData**.
7. Review every store-specific value.
8. Clear any template, page, opcode, or CDN cache.
9. Validate representative products using the checklist below.

The scripted installer creates the configuration group and registers its Admin page. When a former Structured Data installation is detected, matching `PLUGIN_SDATA_*` values are copied into the new `PLUGIN_SUPERDATA_*` settings. The original values are retained for rollback.

If installation reports an existing Structured Data file, SuperData leaves that file untouched. Back it up, rename or remove it, and run the installation again. The installer will not silently delete a customized store file.

## Install on Zen Cart 1.5.6 or 1.5.7

### Storefront file

Copy:

```text
files/legacy/includes/templates/YOUR_TEMPLATE/jscript/jscript_super_data.php
```

to:

```text
includes/templates/ACTUAL_TEMPLATE/jscript/jscript_super_data.php
```

Replace `ACTUAL_TEMPLATE` with the active template directory. Do not upload a folder literally named `YOUR_TEMPLATE`.

### Admin file

Copy:

```text
files/legacy/YOUR_ADMIN/includes/extra_datafiles/super_data.php
```

to:

```text
ACTUAL_ADMIN/includes/extra_datafiles/super_data.php
```

Replace `ACTUAL_ADMIN` with the store's renamed Admin directory. Do not upload a folder literally named `YOUR_ADMIN`.

### Database settings

1. Sign in to Zen Cart Admin.
2. Open **Tools > Install SQL Patches**.
3. Paste or upload `files/legacy/sql/install.sql`.
4. Run the patch once.
5. Open **Configuration > SuperData** and review every value.

### Prevent duplicate markup

Remove or rename the former Structured Data storefront output before enabling SuperData. Common names include `jscript_structured_data.php` and `jscript_plugin_structured_data.php`.

Running both plugins can create duplicate Product, Organization, breadcrumb, Open Graph, and Twitter markup.

## Upgrade an existing legacy installation

Replace the legacy PHP files, then run only the unapplied SQL upgrades in order:

1. `files/legacy/sql/upgrade_to_3.0.2.sql`
2. `files/legacy/sql/upgrade_to_3.0.3.sql`
3. `files/legacy/sql/upgrade_to_3.0.4.sql`

The upgrade patches add missing settings and refresh Admin instructions without resetting existing values. Back up the database before applying them.

## Essential configuration

SuperData cannot infer the store's legal identity, shipping promises, or return rules. Installation creates the fields; the store owner must enter truthful values.

| Area | Settings to review | Guidance |
| --- | --- | --- |
| Output | Enable SuperData, Schema, Open Graph, Twitter Cards | Disable only output types the store does not use. |
| Business | Organization Type, LocalBusiness Type, Name, Legal Name, Description | Most online-only stores should use `OnlineBusiness`. Use `LocalBusiness` only when representing a physical business location. |
| Images | Business Image, Logo | Use complete HTTPS URLs. If Business Image is blank, Logo supplies the Schema `image`. |
| Address | Street, city, region, postal code, country | Country must be a two-letter ISO code such as `US`, `CA`, or `GB`. |
| Contact | Email, telephone, languages, area served, hours | Use a customer-service number in international format. |
| Products | Currency, condition, weight, out-of-stock status | Currency must be a three-letter code such as `USD`. |
| Offers | validFrom, shippingDetails, rate mode, destination, handling and transit | Follow the shipping guidance below. |
| Returns | Policy, days, method, fee, refund type, applicable country | Applicable Country is required to publish the policy. |
| Custom fields | Google Product Category, GTIN, POSM GTIN, POSM MPN | Enter real database column names only when those optional columns exist. |

## Shipping configuration

### Offer shippingDetails

Keep **Offer shippingDetails** enabled when shipping information should appear in product Offers. SuperData publishes the destination and delivery timing with `OfferShippingDetails` and `ShippingDeliveryTime`.

This setting does not calculate a checkout quote. It describes the shipping rule selected by the store owner.

### Shipping rate mode

| Mode | Published output | Correct use |
| --- | --- | --- |
| `MerchantCenter` | Destination and delivery times without an invented rate | Google Merchant Center contains the rates, or shipping varies by destination, product, weight, carrier, or order total. This is the safest default. |
| `Free` | Destination, delivery times, and a `0.00` rate | Shipping is genuinely free for every product and destination represented by the rule. |
| `FlatRate` | Destination, delivery times, and the exact configured charge | The same exact charge applies to every covered product for that destination. |

Do not enter an average, estimate, or preferred marketing amount as a flat rate. Structured data must agree with the price a shopper would actually encounter.

Enter `6.50` for a $6.50 rate. SuperData also tolerates a leading currency symbol, such as `$6.50`, and removes thousands separators, but storing the plain decimal amount is recommended. The mode must still be set to `FlatRate`; entering an amount by itself does not activate flat-rate output.

### Shipping timing

- **Destination country:** two-letter ISO country code.
- **Handling minimum/maximum:** normal business days before shipment.
- **Transit minimum/maximum:** normal business days after shipment.

Minimum values must not exceed the corresponding maximum values.

## validFrom behavior

When enabled, SuperData chooses the Offer `validFrom` date in this order:

1. A valid future product availability date
2. The product creation date
3. The current date as a safe fallback

The same logic is applied to simple, attribute, aggregate, and POSM Offers.

## Return policy configuration

SuperData adds `hasMerchantReturnPolicy` to the business and every Offer when **Returns - Applicable Country** contains at least one country code.

| Setting | Meaning |
| --- | --- |
| Returns - Policy | Finite, unlimited, or not permitted |
| Returns - Days | Return window when the policy is finite |
| Returns - Methods | Mail, store, or kiosk |
| Returns - Type | Free returns or the applicable return fee type |
| Returns - Refund Type | Full refund, store credit, or same-product exchange |
| Returns - Applicable Country | Country where the policy applies; required to publish it |
| Returns - Return Destination Country | Optional country to which returns must be sent |

`FullRefund`, `StoreCreditRefund`, and `ExchangeRefund` map to their corresponding Schema.org refund types. Return Destination Country is optional and no longer controls whether the policy appears.

## Optional product fields

Zen Cart does not provide every Google product field as a core database column. SuperData checks configured columns before using them.

Common defaults are:

- Google Product Category: `products_google_product_category`
- GTIN: `products_gtin`
- POSM GTIN: `pos_gtin`
- POSM MPN: `pos_mpn`

SuperData does not automatically create these product columns. Entering a nonexistent column name does not install it.

## Stores with Google Product Search Feeder or Google Merchant Center Feeder

SuperData and a Google product-feed plugin perform different jobs and can normally run together:

- The feeder creates an XML or TXT product feed submitted to Google Merchant Center.
- SuperData places JSON-LD and social metadata in the storefront page source.

Installing SuperData does **not** require uninstalling Google Product Search Feeder II, Red Headed Stepchild/Reimagined GPF, or another working Merchant Center feeder. SuperData does not replace feed generation, scheduled feed jobs, feed files, Merchant Center submissions, or the feeder's Admin tools.

### Before installing SuperData

1. Back up the complete store database and files.
2. Record the installed feeder and its version.
3. Record the configured Google Product Category and GTIN column names.
4. Confirm whether `products_google_product_category`, `products_gtin`, or another custom products-table column already exists.
5. Generate and save one known-good feed before changing anything.
6. Do not uninstall or delete the feeder merely because SuperData is being installed.

### Shared product columns

SuperData can read fields installed or populated by a feeder. It does not take ownership of those columns, alter their definitions, or delete their product data.

| Existing feeder data | SuperData setting | Action |
| --- | --- | --- |
| `products_google_product_category` | Custom Product Field - Google Product Category | Leave the SuperData default when this is the feeder's active category column. |
| Another Google category column | Custom Product Field - Google Product Category | Enter the exact existing column name. Do not install a duplicate column. |
| `products_gtin` | Custom Product Field - GTIN | Leave the default when this is the store's GTIN column. |
| Another GTIN column | Custom Product Field - GTIN | Enter the exact existing column name. |
| `products_mpn` | Product MPN | SuperData uses this existing field when present in the product data. |
| Feeder-only fields such as material, age group, color, gender, or custom labels | No matching SuperData setting required | Leave them in place for the feeder. SuperData does not remove them. |

If the configured SuperData column does not exist, SuperData skips it safely. That does not mean the feeder column should be removed; it means the SuperData field name must be corrected.

### Shipping when Merchant Center already has the rates

Choose **Shipping rate mode: MerchantCenter** when Merchant Center or the feed contains the actual shipping prices. SuperData still publishes the destination and delivery timing in `shippingDetails`, but does not invent or duplicate a product-page rate.

This setting does not change, delete, or override shipping configured in Merchant Center. It controls only the JSON-LD rendered on the storefront.

### What may need to be removed

Remove or disable only code that also generates storefront structured data, Open Graph tags, or Twitter Cards. A normal Google feed generator does not conflict with SuperData merely because both use product data.

Potential conflicts include old storefront files named like:

```text
includes/templates/YOUR_TEMPLATE/jscript/jscript_structured_data.php
includes/templates/YOUR_TEMPLATE/jscript/jscript_plugin_structured_data.php
```

Back up a conflicting file before renaming or removing it. The modern SuperData installer reports known conflicting Structured Data files and stops; it does not silently delete them.

Do **not** remove these solely to install SuperData:

- feeder catalog generator classes
- feeder Admin pages or language files
- feed output directories or cron jobs still in use
- `products_google_product_category`, `products_gtin`, or other populated product columns
- Google Merchant Center shipping configuration

### If the feeder was uninstalled previously

An earlier feeder may have left useful product columns and data behind. This is normal and often intentional.

1. Inspect the products table or former feeder documentation to identify the columns.
2. Point SuperData to useful existing Google category and GTIN columns.
3. Leave unrelated feeder columns in place unless there is a separate, deliberate database-cleanup plan.
4. Never drop a product column without a verified database backup and confirmation that no installed code uses it.

### If the feeder is being removed intentionally

Follow that feeder's own uninstall instructions separately. First disable its cron job and Merchant Center fetch schedule, then remove its files and configuration as directed by its documentation.

Do not automatically drop optional or custom product columns. The current Reimagined GPF intentionally leaves those columns and data intact during uninstall because automatic removal could destroy product information.

After removal, validate SuperData on a product containing Google category, GTIN, and MPN data. Confirm Merchant Center still receives products through the replacement feed method; SuperData JSON-LD is not a substitute for a Merchant Center product feed.

## Google fields addressed in 3.0.4

Every supported Offer path uses the same enhancement logic. The following recommendations are addressed when their related settings are configured:

- Missing field `validFrom` in `offers`
- Missing field `shippingDetails` in `offers`
- Missing field `hasMerchantReturnPolicy` in `offers`
- Missing field `refundType`
- Missing business `image`

`shippingDetails` includes the destination, handling time, transit time, and an accurate rate only when Free or FlatRate mode permits one to be stated truthfully.

## Validation checklist

Use both:

- [Google Rich Results Test](https://search.google.com/test/rich-results)
- [Schema Markup Validator](https://validator.schema.org/)

Test at least:

- a normal in-stock product
- an out-of-stock product
- a product with attributes at one price
- a product with an attribute price range
- a POSM product, if installed
- products with and without reviews

View the rendered source and search for `application/ld+json`. Confirm there is one intended Product block rather than two plugins producing competing output.

Review the Offer's price, currency, availability, condition, URL, `validFrom`, `shippingDetails`, return policy, SKU, MPN, and GTIN as applicable.

Google describes some recommended-field warnings as non-critical. That means the item can remain valid, not that the store should ignore an available and accurate enhancement.

## Troubleshooting

### No configuration menu

- On Zen Cart 2.x, confirm SuperData is installed in Plugin Manager.
- On legacy Zen Cart, confirm the Admin file is under the actual renamed Admin directory and `install.sql` completed.
- Sign out and back into Admin if menu permissions were cached.

### No markup in page source

- Enable SuperData generation and Schema markup.
- Confirm the storefront file is in the active template.
- Clear template, page, opcode, and CDN caches.
- Check Zen Cart's `/logs` directory.

### Duplicate Product or Organization objects

Disable the previous structured-data output. Do not run SuperData and Structured Data simultaneously.

### shippingDetails is missing

- Enable **Offer shippingDetails**.
- Install the current storefront file.
- Clear caches and search the source for `OfferShippingDetails`.
- Choose `MerchantCenter` when Merchant Center manages shipping rates; destination and delivery timing will still be published.

### hasMerchantReturnPolicy is missing

Enter a two-letter code such as `US` under **Returns - Applicable Country**. Return Destination Country alone does not activate the policy.

### refundType is missing

Confirm a return policy is being published and select **Returns - Refund Type**. It is ignored when returns are not permitted.

### Business image is missing

Enter a complete HTTPS URL under **Business Image** or **Logo**.

## Uninstall and rollback

### Zen Cart 2.x

Use **Modules > Plugin Manager** to uninstall SuperData. Remove package files only after Plugin Manager confirms the uninstall.

### Legacy Zen Cart

1. Back up the database.
2. Run `files/legacy/sql/uninstall.sql` through **Tools > Install SQL Patches**.
3. Remove the installed storefront and Admin PHP files.
4. Clear caches.

Migration does not delete former `PLUGIN_SDATA_*` values, allowing rollback without reconstructing the previous configuration. Never enable the old and new output files together.

## Zen Cart plugin-package compliance

The modern package follows the official [Zen Cart plugin documentation](https://docs.zen-cart.com/dev/plugins/):

- complete, versioned fileset under `zc_plugins/SuperData/v3.0.4`
- `manifest.php` containing name, version, description, authors, Plugin Library ID, supported Zen Cart versions, changelog, and repository
- class-based `Installer/ScriptedInstaller.php` for installation, upgrades, and uninstall
- installer-only language definitions under `Installer/languages/english/main.php`
- no Zen Cart core-file edits
- observer-based storefront integration
- standard `admin` and `catalog` encapsulated directories
- full legacy `YOUR_ADMIN` and `YOUR_TEMPLATE` layout
- GPL license included at repository root
- complete install, upgrade, validation, troubleshooting, and uninstall documentation
- prior authors and contributors acknowledged
- no obfuscated code, advertising, donation buttons, affiliate links, bundled jQuery, or call-home behavior

The legacy SQL files do not hard-code a database prefix. Each distributed edition is a complete installation and does not require an older download first.

## Project history

SuperData has a longer history than the version 3 name suggests.

### 2015: original Super Data Markup

PRO-Webs released the original Super Data project for Zen Cart. The early releases combined product and business structured data with Facebook Open Graph, Google publisher information, Pinterest Rich Pins, and Twitter Cards.

- **1.0.0, February 2015:** initial PRO-Webs release
- **1.1.0, April 2015:** extensive update for new Google and Google Shopping requirements
- **1.1.1, April 2015:** bug fixes

The historical listing remains at [Super Data Markup in the Zen Cart Plugins Library](https://www.zen-cart.com/plugins/super-data-markup-vb1984).

### 2017: Structured Data for Zen Cart

In February 2017, torvista introduced Structured Data for Zen Cart. The author documented that it began with Super Data code plus reviews and breadcrumbs from Zen4All, then grew into a substantial rewrite producing Schema JSON-LD, Facebook Open Graph, and Twitter markup.

The [Zen Cart support thread](https://www.zen-cart.com/threads/198512) records the public development history, testing, bug reports, and fixes.

### 2017 through 2024: community development

Development continued through image handling, reviews, MySQL and PHP compatibility, product descriptions, identifiers, attributes, pricing, weights, breadcrumbs, availability, product types, and return policies.

### 2025 and 2026: modern architecture

The project became an encapsulated Plugin Manager package for modern Zen Cart. Version 2.1 expanded business types, Merchant Return Policy support, Schema values, configuration controls, JSON-LD coverage, and PHP 8 compatibility.

Contributors across the project's life include PRO-Webs/mprough, torvista, Zen4All, ZenExpert, DrByte, lat9, and additional community members recorded in Git history.

### 2026: SuperData version 3

The project returned to the SuperData name and moved to its independent home at [mprough/super_data](https://github.com/mprough/super_data). Version 3 unifies modern and legacy editions, preserves migration from Structured Data settings, and concentrates on accurate Google Product and Offer markup.

Version 3.0.4 completes the work around `validFrom`, `shippingDetails`, business images, merchant return policies, and `refundType` across every supported Offer path. The rename recognizes the original project while preserving the work and authorship that carried it forward for more than a decade.

## Bug reports and support

Before reporting a software defect:

1. Confirm the current version is installed.
2. Reproduce the problem on an unmodified product when possible.
3. Check the Zen Cart `/logs` directory.
4. Include Zen Cart version, PHP version, template, product type, relevant settings, and the validator message.
5. Remove passwords, tokens, private customer data, and private server paths.

Submit reproducible bugs through the [SuperData issue tracker](https://github.com/mprough/super_data/issues).

Store-specific installation, configuration, data repair, customization, and one-on-one support are separate professional services and are not included with the source-code download.

## License and warranty

SuperData is distributed under the GNU General Public License. See `LICENSE` for the complete license text.

The software is provided without warranty. Back up the store, test away from production, and verify output against the store's actual products, shipping rules, return policy, and business information.
