<?php

$loader = require __DIR__ . '/../vendor/autoload.php';
// Hijack the composer autoloader to also load relevant files from the present project when class-loading (see http://stackoverflow.com/questions/12818690/using-composers-autoload)
$loader->add('SupervillainHQ', realpath(__DIR__ . '/../src'));
$loader->add('SupervillainHQ', realpath(__DIR__ . '/../dev/src'));

//putenv('MOCK=auto');
putenv('PHPUNIT=true');

\SupervillainHQ\TestApp::load(__DIR__ . '/../config/config.json');
