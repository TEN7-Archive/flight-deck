![Flight Deck](https://raw.githubusercontent.com/ten7/flight-deck/master/flightdeck-logo.png)

# A set of Docker containers for to run Drupal and Wordpress in production

[![Documentation Status](https://readthedocs.org/projects/flight-deck/badge/?version=latest)](http://flight-deck.readthedocs.io/)

Flight Deck is a set of Docker containers for Drupal and Wordpress. It is lightweight, simple, and Docker and Kubernetes-native, allowing you to stand up a local development environment quickly after installing Docker, or running your site in production.

## Library

| Container | Provides |
| --------- | ------------ |
| [ten7/flight-deck-web](https://hub.docker.com/r/ten7/flight-deck-web/) | Apache and PHP |
| [ten7/flight-deck-db](https://hub.docker.com/r/ten7/flight-deck-db/) | A MySQL compatible databse |
| [ten7/flight-deck-varnish](https://hub.docker.com/r/ten7/flight-deck-varnish/) | HTTP caching |
| [ten7/flight-deck-solr](https://hub.docker.com/r/ten7/flight-deck-solr/) | Custom search |

## Deployment on Kubernetes

Flight Deck is configured out of the box to run in production on Kubernetes. For the easiest deployment, consider using the [`ten7.flightdeck_cluster`](https://galaxy.ansible.com/ten7/flightdeck_cluster) role on Ansible Galaxy. There's extensive documentation in the [project's readme](https://github.com/ten7/ansible-role-flightdeck-cluster).

## Where's the code?

This repository no longer houses the Flight Deck container source. Instead, it's been broken up into multiple repositories, each with their own documentation:

* https://github.com/ten7/flight-deck-web
* https://github.com/ten7/flight-deck-db
* https://github.com/ten7/flight-deck-varnish
* https://github.com/ten7/flight-deck-solr

## How can I deploy my site with Flight Deck?

The best practice is to "bake in" you site code into the container. That way, the container itself has all the immutable code, without the need to use NFS or locally attached volumes. 

We have an example Dockerfile on the [ten7/flight-deck-drupal](https://github.com/ten7/flight-deck-drupal) repo.

## Support

Flight Deck is used and supported by [TEN7](https://ten7.com/). [Post an issue](https://github.com/ten7/flight-deck/issues/new) on our Github page for help.

## License

See [LICENSE](https://raw.githubusercontent.com/ten7/flight-deck/master/LICENSE).
