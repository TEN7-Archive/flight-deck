TEN7 Flight Deck v2.2.2   2018-07-30
====================================
* Updated Drush root to use APACHE_DOCROOT_DIR.
* Updated default shell directory to APACHE_DOCROOT_DIR.

TEN7 Flight Deck v2.2.1   2018-07-10
====================================
* Added MSSQL PDO support.

TEN7 Flight Deck v2.2.0   2018-06-14
====================================
* Added Solr 4.10 container
* Added custom Solr schema support.
* Added apachesolr module support to solr:4.10, and solr:5.5.

TEN7 Flight Deck v2.1.10  2018-06-07
====================================
* Added Compose override example file
* Disabled XDebug out of the box as it slows Mac and Win.

TEN7 Flight Deck v2.1.9   2018-05-29
====================================
* Fixed APACHE_DOCROOT_DIR to also set the DocumentRoot

TEN7 Flight Deck v2.1.8   2018-03-09
====================================
* Added HTTPS support to PHP 7 container with self-signed cert.

TEN7 Flight Deck v2.1.7   2018-03-23
====================================
* Added Python MySQL DB support for Ansible.
* Added global settings to `.env`.

TEN7 Flight Deck v2.1.6   2018-03-19
====================================
* Added more informative bash prompt.

TEN7 Flight Deck v2.1.5   2018-02-28
====================================
* Added iconv library to web containers.

TEN7 Flight Deck v2.1.4   2018-02-27
====================================
* Fixed Solr container not staying up on second start.

TEN7 Flight Deck v2.1.3   2018-02-22
====================================
* Added compass command to web container.

TEN7 Flight Deck v2.1.2   2018-02-20
====================================
* Fixed missing SASS and SASS Globbing.

TEN7 Flight Deck v2.1.1   2018-02-20
====================================
* Removed --chown flag from varnish Dockerfile that broke hub builds.

TEN7 Flight Deck v2.1.0   2018-02-20
====================================
* Completely new solr container based on the official Solr image
* Solr container has Search API integration out of the box
* Completely new Varnish container based on Alpine 3.6
* Varnish container now runs as non-root

TEN7 Flight Deck v2.0.0   2018-02-16
====================================
* Completely new DB container based on Alpine 3.6
* Web and DB containers now run as non-root
* Drupal multi-site support
* Security enhancements for Apache and MySQL
* Increased OpCaching and PHP Timeouts
* Updated documentation
* Extensible entrypoints for easier customization
* Renamed from Dockstack to Flight Deck
