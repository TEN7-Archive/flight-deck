# Getting started

Flight Deck has only been tested on macOS and Linux. It should work on Windows, but this is untested.

## Installing Docker

Flight Deck is based on Docker. Docker allows you to spin up multiple, lightweight virtual environments on your system called "containers". You can find out more about containers on [training.docker.org](https://training.docker.com/introduction-to-docker).

For macOS and Windows:
1. [Download](https://www.docker.com) Docker for macOS or Docker for Windows.
2. Run the installer and follow on-screen instructions.
3. Restart your computer when finished.

For Linux:
1. Consult your distribution's documentation for the proper installation method. 

## Adding Flight Deck to your project

When using Flight Deck, it's best to add it permanently to your project repository. That way, anyone working on that project has access to the some stack of containers.

1. Reorganize your repository such that the `index.php` file is in a **subdirectory** of your project root named `src`:
```
/path/to/my_project
├── .git/
└── src/
    ├── core/
    └── index.php
```

2. Download a copy of Flight Deck from github. This can be either from a zip, or cloning the repo.
3. Copy the `db-backups` directory into the root of your project.
```
/path/to/my_project
├── .git/
├── db-backups/
│   └── .gitignore
└── src/
    ├── core/
    └── index.php
```
4. Copy the `.env` file into the root of your project.
```
/path/to/my_project
├── .git/
├── .env
├── db-backups/
│   └── .gitignore
└── src/
    ├── core/
    └── index.php
```
5. Copy `docker-compose.yml` and `docker-compose.override.yml.example` into the root of your project.
```
/path/to/my_project
├── .git/
├── .env
├── db-backups/
│   └── .gitignore
├── docker-compose.yml
├── docker-compose.override.yml.example
└── src/
    ├── core/
    └── index.php
```
6. Create the `config/` directory:
```
/path/to/my_project
├── .git/
├── .env
├── db-backups/
│   └── .gitignore
├── config/
│   └── .gitkeep
├── docker-compose.yml
├── docker-compose.override.yml.example
└── src/
    ├── core/
    └── index.php
```

## Configuring Flight Deck

Flight Deck keeps it's configuration settings in the `.env` file. This includes the database name, user, and password, the varnish secret, if XDebug is enabled, and more.

The `.env` file comes with sensible defaults, but you may wish to change them.


## Database connection

As a set of Docker containers, the database connection information for your site is somewhat different than you may expect. While all the containers are running on your host OS and are accessible via `localhost`, Drupal sees itself on a server named `web`, and the database is on another server named `db`. As a result, we need to configure Drupal to access the database remotely.

If Drupal is already installed:
1. Use your text editor of choice to open you `settings.php` or `settings.local.php` file.
2. Update the $database variable to the following. This will instruct Drupal to use the MySQL login specified in the `.env` file:
```php
$databases['default']['default'] = array(
  'database' => getenv('MYSQL_DATABASE'),
  'username' => getenv('MYSQL_USER'),
  'password' => getenv('MYSQL_PASSWORD'),
  'host' => 'db',
  'port' => '',
  'driver' => 'mysql',
  'prefix' => '',
 );
```
3. Save the file.

If Drupal is not installed:
1. Open the `.env` file. Note the values of `MYSQL_DATABASE`, `MYSQL_USER`, and `MYSQL_PASSWORD`.
2. Start Flight Deck. See Using Flight Deck for details.
3. Begin the installation process as normal.
4. On the **Database configuration** page, enter the **Database name**, **username**, and **password** as specified in the `.env` file.
5. Open **Advanced Options**. For the **Host** enter `db`.
6. Continue with the installation.

## Create a URL alias

Accessing Flight Deck using `localhost` poses a number of problems. The biggest of which is that it's a special domain name, which creates problems for complex CMSes like Drupal. Many sites also rely on `.htaccess` rewrite rules to redirect traffic to an HTTPS or `www.`-prefixed domain.

To solve these issues, it's ***highly*** recommended to create a *URL alias*.

On Linux and macOS:

1. Open a terminal emulator.
2. Open the `/etc/hosts` file using your favorite text editor. Be sure to use `sudo` to run the command as the root user: `sudo vi /etc/hosts`
3. Notice there are two columns of text, one is IP address, the other is host names.
4. At the end of the file, enter a new row. Use `127.0.0.1` as the IP address, and `docker.test` as the hostname:
```
127.0.0.1 docker.test
```
5. Check the file for typos, particularly "docker.te**x**t".

On Windows:

1. Using the Start Menu, locate the **Notepad** application.
2. Right click **Notepad**, and select **Run as administrator**.
3. Open the following file for editing: `C:\Windows\System32\Drivers\etc\hosts`
4. Notice there are two columns of text, one is IP address, the other is host names.
5. At the end of the file, enter a new row. Use `127.0.0.1` as the IP address, and `docker.test` as the hostname:
```
127.0.0.1 docker.test
```
5. Check the file for typos, particularly "docker.te**x**t".

You only need to create the `docker.test` alias once, no matter how many Flight Deck-powered projects you have on your system. You may also choose to add a different URL alias such as 'docker.test', '[your_site_name].test', and so on.
