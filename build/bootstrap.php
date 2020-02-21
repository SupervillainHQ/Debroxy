<?php
/**
 * Bootstrap for the executable phar
 *
 * Currently available commands:
 *
 */

use SupervillainHQ\Debroxy\Cli\DebroxyCliApplication;

$arguments = array_values($argv);

$path = array_shift($arguments);
$pharPath = dirname(realpath($path));
$projectPath = dirname($pharPath);
$vendorPath = "{$projectPath}/vendor";
include "{$vendorPath}/autoload.php";

DebroxyCliApplication::run("{$projectPath}/config/config.json");

