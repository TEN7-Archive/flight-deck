<?php
/**
 * @file
 *
 * Additional Drush startup customization.
 */
if (file_exists('/.dockerenv')) {
  $options['uri'] = 'http://docker.local';
  $options['root'] = '/var/www/html';
}
