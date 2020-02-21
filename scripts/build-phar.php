<?php
/**
 * build-phar.php.
 *
 * TODO: Documentation required!
 */

/**
 * Build the executable phar
 */
$stub = <<<STUB
#!/usr/bin/env php
<?php Phar::mapPhar("debroxy.phar");
include 'phar://debroxy.phar/bootstrap.php';
__HALT_COMPILER();
?>
STUB;


$phar = new Phar('build/debroxy.phar');
//$phar->buildFromDirectory('src/');
$phar->addFile('build/bootstrap.php', 'bootstrap.php');
$phar->setStub($stub);

