<?php 
/**
 * super_data_body.php
 *
 * @package facebook open graph forked for super data
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: super_data_body.php 2 2015-02-03 01:19:41Z prowebs $
 */
if (FACEBOOK_OPEN_GRAPH_STATUS == 'true') { ?>
<?php if ($current_page_base=='product_info'){ ?> 
<?php     
    $res = $db->Execute($sql);
    $sql = "select p.products_id, pd.products_name,
                  pd.products_description, p.products_model,
                  p.products_quantity, p.products_image,
                  pd.products_url, p.products_price,
                  p.products_tax_class_id, p.products_date_added,
                  p.products_date_available, p.manufacturers_id, p.products_quantity,
                  p.products_weight, p.products_priced_by_attribute, p.product_is_free,
                  p.products_qty_box_status,
                  p.products_quantity_order_max,
                  p.products_discount_type, p.products_discount_type_from, p.products_sort_order, p.products_price_sorter
           from   " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd
           where  p.products_status = '1'
           and    p.products_id = '" . (int)$_GET['products_id'] . "'
           and    pd.products_id = p.products_id
           and    pd.language_id = '" . (int)$_SESSION['languages_id'] . "'";
    $product_info = $db->Execute($sql); ?>
<?php } ?>
<meta itemprop="twitter" name="twitter:card" content="summary" />
<div itemscope itemtype="http://data-vocabulary.org/Organization">
<?php if (FACEBOOK_OPEN_GRAPH_TYPE != '') { ?>
<meta itemprop="type" content="<?php echo FACEBOOK_OPEN_GRAPH_TYPE; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_LOGO != '') { ?>
<meta itemprop="logo" content="<?php echo FACEBOOK_OPEN_GRAPH_LOGO; ?>" />
<?php } ?>
<div itemprop="address" itemscope itemtype="http://data-vocabulary.org/Address" />
<?php if ( ((FACEBOOK_OPEN_GRAPH_STREET_ADDRESS != '') or (FACEBOOK_OPEN_GRAPH_CITY != '') or (FACEBOOK_OPEN_GRAPH_STATE != '') or (FACEBOOK_OPEN_GRAPH_ZIP != ''))) { ?> 
<meta property="og:street-address" itemprop="street-address" content="<?php echo FACEBOOK_OPEN_GRAPH_STREET_ADDRESS; ?>" />
<meta property="og:locality" itemprop="locality" content="<?php echo FACEBOOK_OPEN_GRAPH_CITY; ?>" />
<meta property="og:region" itemprop="region" content="<?php echo FACEBOOK_OPEN_GRAPH_STATE; ?>" />
<meta property="og:postal-code" itemprop="zipcode" content="<?php echo FACEBOOK_OPEN_GRAPH_ZIP; ?>" />
<?php }?>
<?php if (FACEBOOK_OPEN_GRAPH_COUNTRY != '') { ?>
<meta property="og:country_name" itemprop="addressCountry" content="<?php echo FACEBOOK_OPEN_GRAPH_COUNTRY; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_EMAIL != '') { ?>
<meta property="og:email" itemprop="email" content="<?php echo FACEBOOK_OPEN_GRAPH_EMAIL; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_PHONE != '') { ?>
<meta property="og:phone_number" itemprop="tel" content="<?php echo FACEBOOK_OPEN_GRAPH_PHONE; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_FAX != '') { ?>
<meta itemprop="faxNumber" content="<?php echo FACEBOOK_OPEN_GRAPH_FAX; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_TID != '') { ?>
<meta itemprop="taxID" content="<?php echo FACEBOOK_OPEN_GRAPH_TID; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_VAT != '') { ?>
<meta itemprop="vatID" content="<?php echo FACEBOOK_OPEN_GRAPH_VAT; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_DUNS != '') { ?>
<meta itemprop="duns" content="<?php echo FACEBOOK_OPEN_GRAPH_DUNS; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_LEG != '') { ?>
<meta itemprop="legalName" content="<?php echo FACEBOOK_OPEN_GRAPH_LEG; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_TWUSER != '') { ?>
<meta itemprop="twitter" name="twitter:site" content="<?php echo FACEBOOK_OPEN_GRAPH_TWUSER; ?>">
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_FBPG != '') { ?>
<meta itemprop="facebook" content="<?php echo FACEBOOK_OPEN_GRAPH_FBPG; ?>" />
<?php } ?>
<meta itemprop="name" name="twitter:title"  content="<?php echo META_TAG_TITLE; ?>" />
<meta property="og:site_name" content="<?php echo STORE_NAME; ?>" />
<meta itemprop="url" name="twitter:url" content="<?php echo $canonicalLink; ?>" />
<meta property="og:url" content="<?php echo $canonicalLink; ?>" />
<?php if (FACEBOOK_OPEN_GRAPH_ADMINID != '') { ?>
<meta property="fb:admins" content="<?php echo FACEBOOK_OPEN_GRAPH_ADMINID; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_APPID != '') { ?>
<meta property="fb:app_id" content="<?php echo FACEBOOK_OPEN_GRAPH_APPID; ?>" />
<?php } ?>
<?php
  if (isset($facebook_override_image) && $facebook_override_image != '') {
    $fb_image = $facebook_override_image;
  } else {
    if (isset($_GET['products_id'])) { // use products_image if products_id exists
      $facebook_image = $db->Execute("select p.products_image from " . TABLE_PRODUCTS . " p where products_id='" . (int)$_GET['products_id'] . "'");
      $fb_image = HTTP_SERVER . DIR_WS_CATALOG . DIR_WS_IMAGES . $facebook_image->fields['products_image'];
    } elseif (isset($_GET['cPath'])) {
      $fb_cPath_array = explode('_', $_GET['cPath']);
      $fb_cPath_size = sizeof($fb_cPath_array);
      $fb_categories_id = $fb_cPath_array[$fb_cPath_size - 1]; 
      $fb_categories_image = HTTP_SERVER . DIR_WS_CATALOG . DIR_WS_IMAGES . zen_get_categories_image($fb_categories_id);
    }
  }
  if ($fb_image == '' && FACEBOOK_OPEN_GRAPH_DEFAULT_IMAGE != '') { // if no products image, use the default image if enabled
   $fb_image = FACEBOOK_OPEN_GRAPH_DEFAULT_IMAGE;
  }
  if ($fb_image != '') {
?>
<meta property="og:image" content="<?php echo $fb_image; ?>" />
<meta itemprop="image" name="twitter:image" content="<?php echo $fb_image; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_LOCALE != '') { ?>
<meta property="og:locale" http-equiv="Content-Language" content="<?php echo FACEBOOK_OPEN_GRAPH_LOCALE; ?>" />
<?php } ?>
<?php if ($current_page_base=='product_info'){ ?>
<?php if ($flag_show_product_info_manufacturer == 1 and $products_manufacturer != '') { ?>
<meta property="og:brand" itemprop="manufacturer" content="<?php echo $manufacturers_name; ?>" />
<?php } ?>
<div itemscope itemtype="http://schema.org/Product">
<meta property="og:type" content="product" />
<meta itemprop="name" content="<?php echo $products_name; ?>" />
<meta itemprop="description" name="twitter:description" content="<?php echo META_TAG_DESCRIPTION; ?>" />
<div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
<?php if ($flag_show_product_info_model == 1 and $products_model != '') { ?>
<meta property="product:retailer_part_no" itemprop="mpn" content="<?php echo $products_model; ?>" />
<?php } ?>
<?php if ($flag_show_product_info_quantity == 1 and $products_quantity != '') { ?>
<meta property="og:quantity" itemprop="inventoryLevel" content="<?php echo $products_quantity; ?>" />
<?php } ?>
<meta property="og:price:amount" itemprop="price" content="<?php echo $specials_new_products_price = (round(zen_get_products_actual_price($product_info_metatags->fields['products_id']),2)); ?>" />
<?php if (FACEBOOK_OPEN_GRAPH_CUR != '') { ?>
<meta property="product:price:currency" itemprop="priceCurrency" content="<?php echo FACEBOOK_OPEN_GRAPH_CUR; ?>" />
<?php } ?>
<meta property="og:provider_name" itemprop="seller" content="<?php echo STORE_NAME; ?>" />
<?php if ($products_quantity > 0) { ?><meta property="og:availability" itemprop="availability" content="in_stock" / ><?php } ?>
<?php if ($products_quantity == 0) { ?><meta property="og:availability" itemprop="availability" content="out_of_stock" / ><?php }?>" />
<meta property="og:product_id" itemprop="sku" content="<?php echo $products_quantity; ?>" />
<meta property="og:category" itemprop="category" content="<?php echo $categories->fields['categories_name']; ?>" />
<?php if (FACEBOOK_OPEN_GRAPH_DTS != '') { ?>
<meta itemprop="deliveryLeadTime" content="<?php echo FACEBOOK_OPEN_GRAPH_DTS; ?>" />
<?php } ?>
</div>
<div itemscope itemtype="http://data-vocabulary.org/Product">
<?php if (FACEBOOK_OPEN_GRAPH_PAY1 != '') { ?>
<link itemprop="http://purl.org/goodrelations/v1#acceptedPaymentMethods" href="http://purl.org/goodrelations/v1#<?php echo FACEBOOK_OPEN_GRAPH_PAY1; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_PAY2 != '') { ?>
<link itemprop="http://purl.org/goodrelations/v1#acceptedPaymentMethods" href="http://purl.org/goodrelations/v1#<?php echo FACEBOOK_OPEN_GRAPH_PAY2; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_PAY3 != '') { ?>
<link itemprop="http://purl.org/goodrelations/v1#acceptedPaymentMethods" href="http://purl.org/goodrelations/v1#<?php echo FACEBOOK_OPEN_GRAPH_PAY3; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_PAY4 != '') { ?>
<link itemprop="http://purl.org/goodrelations/v1#acceptedPaymentMethods" href="http://purl.org/goodrelations/v1#<?php echo FACEBOOK_OPEN_GRAPH_PAY4; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_PAY5 != '') { ?>
<link itemprop="http://purl.org/goodrelations/v1#acceptedPaymentMethods" href="http://purl.org/goodrelations/v1#<?php echo FACEBOOK_OPEN_GRAPH_PAY5; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_PAY6 != '') { ?>
<link itemprop="http://purl.org/goodrelations/v1#acceptedPaymentMethods" href="http://purl.org/goodrelations/v1#<?php echo FACEBOOK_OPEN_GRAPH_PAY6; ?>" />
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_COND != '') { ?>
<meta property="og:condition" itemprop="condition" content="<?php echo FACEBOOK_OPEN_GRAPH_COND; ?>" />
<?php } ?>
<?php } ?>
</div></div></div></div>
<?php } ?>