TEN7 Flight Deck v3.3.3   2019-3-13
====================================
* Various fixes for k8s.
* Added fileinfo extension to web, cli for Drupal 8.7.
* Fix issue with varnish purge ACL restricted to localhost.
* New, optional mariadb 10 container with YAML-based configuration and multi-tenancy
* Fixed Drush at 9.5.x due to sql-sync regression

TEN7 Flight Deck v3.2.0   2019-2-28
====================================
* Reduced size of ten7/flight-deck-web by 200MB!
* New ten7/flight-deck-web:7.2-imagemagick container.

TEN7 Flight Deck v3.1.0   2019-2-5
====================================
* Added some commonly used PHP tuning parameters to .env

TEN7 Flight Deck v3.0.0   2019-2-1
====================================
* Web and CLI containers are now PHP 7.2.
* New, unified docker-compose.yml.
* HTTPS support enabled by default.
* Varnish updated to 6.1.
* Memcache updated to 1.5.
* Drush 9 (finally!).
* Node 10 with user-local global installs.
* Dart sass 1.6, replacing ruby sass.
* Ansible updated to 2.7.
* Updated all containers to Alpine 3.9.
* Many updates to documentation.

TEN7 Flight Deck v2.4.0   2018-12-12
====================================
* Added new CLI container for cron and SSH.
* Added global CONFIG_DIR variable, default "/config".
* Added global SECRETS_DIR variable, default "/secrets".
* Added the ability to load container configuration from files at $CONFIG_DIR/VAR_NAME
* Added the ability to load container sensitive configuration (secrets) from files at $SECRETS_DIR/VAR_NAME
* Added default Ansible hosts file with localhost.
* Added default Ansible configuration file (sorry, cows!).
* Fixed bug where T7_SITE_ENVIRONMENT was not respected in Apache.
* Added XMLReader support.

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
