<?php

declare(strict_types=1);

define('FILENAME_DEFAULT', 'index');
define('HTTP_SERVER', 'https://example.test');
define('DIR_WS_CATALOG', '/');
define('DIR_WS_IMAGES', 'images/');

function zen_href_link(string $page, string $parameters): string
{
    return HTTP_SERVER . '/' . $page . '.php?' . $parameters;
}

function sdata_set_listItem(int $position, string $url, string $name, string $image): array
{
    return compact('position', 'url', 'name', 'image');
}

function runCategoryLoop(string $loop, array $sub_cat_data): array
{
    $listing_schema = [];
    $list_pos = 1;
    $base_cPath = '536_53_';
    // Execute the production loop with fixture rows in place of a Zen Cart database.
    eval($loop);
    return $listing_schema;
}

$missing = [
    ['categories_id' => 504, 'categories_name' => null],
    ['categories_id' => 506, 'categories_name' => '  '],
    ['categories_id' => 507],
];
$rows = [
    $missing[0],
    ['categories_id' => 505, 'categories_name' => 'Motors', 'categories_image' => 'motors.png'],
    $missing[1],
    $missing[2],
    ['categories_id' => 508, 'categories_name' => 'Blower Shafts'],
];
$expected = [
    [
        'position' => 1,
        'url' => 'https://example.test/index.php?cPath=536_53_505',
        'name' => 'Motors',
        'image' => 'https://example.test/images/motors.png',
    ],
    [
        'position' => 2,
        'url' => 'https://example.test/index.php?cPath=536_53_508',
        'name' => 'Blower Shafts',
        'image' => '',
    ],
];

foreach (array_slice($argv, 1) as $file) {
    $source = file_get_contents($file);
    $start = strpos($source, 'foreach ($sub_cat_data as $list_category) {');
    $end = $start === false ? false : strpos($source, "\n        break;", $start);
    if ($end === false) {
        throw new RuntimeException('Cannot locate the subcategory loop in ' . $file);
    }
    $loop = substr($source, $start, $end - $start);
    if (runCategoryLoop($loop, $rows) !== $expected || runCategoryLoop($loop, $missing) !== []) {
        throw new RuntimeException('Unexpected subcategory listing in ' . $file);
    }
    echo 'Subcategory schema passed for ' . $file . PHP_EOL;
}
