<?php
/**
 * @file
 *
 * Additional Drush startup customization.
 */
if (file_exists('/.dockerenv')) {
  $options['uri'] = 'http://docker.test';
  $options['root'] = '/var/www/html';
}
