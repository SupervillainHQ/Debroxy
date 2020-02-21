<?php
/**
 * index.php.
 *
 * TODO: Documentation required!
 */
use \SuperVillainHQ\Debroxy\DebuggingProxyApplication;

$loader = require_once __DIR__ . '/../../vendor/autoload.php';
// Actually not necessary if the composer.json contains an autoload.psr-0 entry!
//$loader->add('SuperVillainHQ', __DIR__ . '/../apps/webs/src');

DebuggingProxyApplication::run(__DIR__ . '/../config/config.json');
