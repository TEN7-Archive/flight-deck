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
