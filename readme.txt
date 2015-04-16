Zen Cart Super Data  1.1.1
Publisher: PRO-Webs, Inc

This module is an intermediate installation for Zen Cart 1.5.4 and tested on PHP 5.5.17. I may very well work on other Zen cart versions too.

This module will create the required data for the following schemas as well as Facebook OpenGraph, Google Publisher, Pinterest Rich Pins and Twitter Cards.

    http://data-vocabulary.org/Organization
    http://data-vocabulary.org/Address
    http://schema.org/Product
    http://schema.org/Offer
    http://data-vocabulary.org/Product
    
    
Please direct support questions here (https://pro-webs-support.com/)

INSTALLATION INSTRUCTIONS
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

FIRST MAKE A FULLE BACKUP OF YOUR WEBSITE'S FILES AND DATABASE!

1. !!!! Backup your database and affected files !!!!
2. Upload the files to your Zen Cart shop directory, maintaining their file structure.
3. Install the included SQL patch in your Zen cart admin.

!!!!! NOTE: Run the uninstall for NUMINIX OpenGraph BEFORE if you have it installed.  !!!!
This file is located at sql/fb_opengraph_uninstall.sql

4. Open includes\templates\your_template\common\html_header.php
Find:
 
 // DEBUG: echo '<!-- I SEE cat: ' . $current_category_id . ' || vs cpath: ' . $cPath . ' || page: ' . $current_page . ' || template: ' . $current_template . ' || main = ' . ($this_is_home_page ? 'YES' : 'NO') . ' -->';
?>

Add directly after:
<?php require($template->get_template_dir('super_data_head.php',DIR_WS_TEMPLATE, $current_page_base,'templates'). '/super_data_head.php'); ?>

Before the ending </head> tag.

5. In your Zen Cart admin use sql/install.sql under Tools >> Install sql patches.

6. Read CAREFULLY and populate the new data in Configuration >> Super Data in your Zen cart admin.

7. Checking your data                            
    https://cards-dev.twitter.com/validator
    https://developers.pinterest.com/rich_pins/validator/
    https://developers.facebook.com/tools/debug/og/object/
    -- NOTE the redirect error in Facebook is caused by the native Zen Cart canonical structure.
       I DO NOT recommend that you change it by editing includes/init_includes/init_canonical.php
       and changing $includeCPath = FALSE; to $includeCPath = TRUE; 
    http://developers.pinterest.com/rich_pins/validator/

Version History:
02/03/2015 BETA 1.0.0 PRO-Webs.net  - Initial Release
04/09/2015 1.1.0 PRO-Webs.net  - Updated and overhauled for new JSON requirements from Google & Google Shopping.
04/15/2015 1.1.1 PRO-Webs.net - Bug fixes