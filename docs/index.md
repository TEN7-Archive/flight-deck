# Flight Deck

TEN7's Flight Deck is a library of containers for local Drupal development. Flight Deck is lightweight, simple, and Docker-native, allowing you to stand up a local development environment quickly after installing Docker.

## Library

| Container | Service name | Tags | Public Port | Supports Drupal |
| --------- | ------------ | ---- | ----------- | --------------- |
| [ten7/flight-deck-web](https://hub.docker.com/r/ten7/flight-deck-web/) | web | 7.2, latest | 80, 443 | 7, 8 |
| [ten7/flight-deck-cli](https://hub.docker.com/r/ten7/flight-deck-cli/) | cli | 7.2, latest | 22 | 7, 8 |
| [ten7/flight-deck-db](https://hub.docker.com/r/ten7/flight-deck-db/) | db | latest | 3306 | all |
| [phpmyadmin/phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/) | pma | latest | 8001 | all |
| [mailhog/mailhog](https://hub.docker.com/r/mailhog/mailhog/) | mailhog | latest | 8002 | all |
| [_/memcached](https://hub.docker.com/_/memcached/) | memcached | 1.5-alpine |   | all |
| [ten7/flight-deck-varnish](https://hub.docker.com/r/ten7/flight-deck-varnish/) | varnish | 6.6, latest | 8004, 8005 | all |
| [ten7/flight-deck-solr](https://hub.docker.com/r/ten7/flight-deck-solr/) | solr | 6.6, latest | 8003 | 7, 8 |

## Support

You can always [post an issue](https://github.com/ten7/flight-deck/issues/new) on our Github page.

## License

See [LICENSE](https://raw.githubusercontent.com/ten7/flight-deck/master/LICENSE).
