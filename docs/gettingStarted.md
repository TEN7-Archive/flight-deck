# Getting started

Dockstack has only been tested on macOS and Linux. It should work on Windows, but this is untested.

## Installing Docker

Dockstack, as its name implies, is based on Docker. Docker allows you to spin up multiple, lightweight virtual environments on your system called "containers". You can find out more about containers on [training.docker.org](https://training.docker.com/introduction-to-docker).

1. [Download](https://www.docker.com/products/overview) Docker for macOS or Docker for Windows.
2. Run the installer and follow on-screen instructions.
3. Restart your computer when finished.

## Adding Dockstack to your project

When using Dockstack, it's best to add it permanently to your project repository. That way, anyone working on that project has access to the some stack of containers.

Dockstack assumes that the docroot/webroot of your PHP project is in a subdirectory of your git repository. This is typically named `docroot`, `webroot`, `src`, or `public_html`. Dockstack assumes `src`.

1. Reorganize your repository, if necessary.
2. Download a copy of Dockstack from github. This can be either from a zip, or cloning the repo.
3. Copy the `db-backups` directory into the root of your project.
4. Copy the `.env` file into the root of your project.
5. If your project is Drupal 6 or 7, copy `docker-compose.d7-apache.yml` into the root of your project. For Drupal 8, copy `docker-compose.d8-apache.yml`.
6. Rename the file you copied in the previous step to `docker-compose.yml`.

## Configuring settings

Dockstack keeps it's configuration settings in the `.env` file. This includes the database name, user, and password, the varnish secret, if XDebug is enabled, and more.

The `.env` file comes with sensible defaults, but you may wish to change them.

## Starting Dockstack

Once the proper files have been deployed and the .env file configured, you're ready to start Dockstack for the first time.

1. Place a MySQL dump in the db-backups directory. This can be in uncompressed SQL, but also in gzip, zip, xs, or lzo format.
2. Open a terminal and change to your project root.
3. Start Dockstack with the following command: `docker-compose up -d`
4. Note that the first build will take longer, as container images need to be downloaded from hub.docker.com. Subsequent restarts will be on the order of seconds.
5. Using a web browser, navigate to `localhost`. 
