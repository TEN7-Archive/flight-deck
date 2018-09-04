<?php
/**
 * @file
 *
 * Additional Drush startup customization.
 */

$apache_docroot_dir = getenv('APACHE_DOCROOT_DIR');

if (file_exists('/.dockerenv')) {
  $options['uri'] = 'http://docker.test';
  $options['root'] = empty($apache_docroot_dir) ? '/var/www/html' : $apache_docroot_dir;
}
