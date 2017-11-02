<?php
/**
 * @file
 *
 * Contains Drush site alias definitions.
 */

/**
 * Alias for the preview environment.
 */
$aliases['docker'] = array (
  'root' => '/var/www/html',
  'uri' => 'http://docker.local',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
  ),
);
