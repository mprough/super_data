<?php 
/**
 * super_data_head.php
 *
 * @package facebook open graph forked for super data
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: super_data_head.php 2 2015-02-03 01:19:41Z prowebs $
 */
if (FACEBOOK_OPEN_GRAPH_STATUS == 'true') { ?>
<meta property="og:title" content="<?php echo META_TAG_TITLE; ?>" />
<meta property="og:description" content="<?php echo META_TAG_DESCRIPTION; ?>" />
<meta property="og:site_name" content="<?php echo STORE_NAME; ?>" />
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
<?php } ?>
<?php if (FACEBOOK_OPEN_GRAPH_TYPE != '') { ?>
<meta property="og:type" content="<?php echo FACEBOOK_OPEN_GRAPH_TYPE; ?>" />
<?php } ?>
<?php if (GOOGLE_PUBLISHER != '') { ?>
<link href="<?php echo FACEBOOK_OPEN_GRAPH_GOOGLE_PUBLISHER; ?>" rel=publisher />
<?php } ?>
<?php } ?>