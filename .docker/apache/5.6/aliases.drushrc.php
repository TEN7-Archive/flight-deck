<?php
/**
 * @file
 *
 * Contains Drush site alias definitions.
 */

$apache_docroot_dir = getenv('APACHE_DOCROOT_DIR');

/**
 * Alias for the preview environment.
 */
$aliases['docker'] = array (
  'root' => empty($apache_docroot_dir) ? '/var/www/html' : $apache_docroot_dir,
  'uri' => 'http://docker.test',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
  ),
);
