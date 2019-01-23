# Using Flight Deck

## Preparation

Before starting Flight Deck, you need to be sure that other local web development environments stuch as MAMP, WAMP, Acquia Dev Desktop, and even locally installed services such as Solr are stopped.

Flight Deck acquires many of the same ports as these products, and they **cannot** be used at the same time.  

1. Stop MAMP, WAMP, Acquia Dev Desktop, and any local web server services using their perferred method.
2. Stop any existing Docker containers:
```shell
docker kill $(docker ps -q)
```

## Starting

Once the proper files have been deployed and the `.env` file configured, you're ready to start Flight Deck for the first time.

1. Navigate to the directory containing the `docker-compose.yml` file.
```shell
cd path/to/my_project
```
2. Start Flight Deck using the following command:
```shell
docker-compose up -d
```
3. Using a web browser, navigate to `localhost`.

## Using CLI tools

Flight Deck includes several CLI tools in the `web` container for your use. This includes Drush, Drupal Console, npm, sass, and others. This allows you to leverage these tools without installing them on your host OS.

To use the CLI tools:

1. Navigate to the directory containing the `docker-compose.yml` file.
```shell
cd path/to/my_project
```
2. Start Flight Deck if you haven't already.
3. Start an interactive shell session into the `web` container:
```shell
docker-compose exec web /bin/bash
```
4. Use Drush or any of the included command line applications as needed.
5. When finished, leave the interactive session:
```shell
exit
```

## Stopping

When your done with using Flight Deck, you can stop it as follows:

1. Navigate to the directory containing the `docker-compose.yml` file.
```shell
cd path/to/my_project
```
2. Stop Flight Deck:
```shell
docker-compose kill
```

## Multiple Projects

Flight Deck is designed to run only one Drupal codebase at a time. If you have multiple projects relying on Flight Deck you must shutdown Flight Deck for your current project before moving to the next one.

Remember, commands like `docker-compose` look at your current working directory to know which `docker-compose.yml` file to read.

1. Navigate to the directory of the project you're finished using.
2. Stop Flight Deck as described above.
3. Change to the directory for the next project you'll be working on.
4. Start Flight Deck as described above.

## Loading Databases

Flight Deck provides two options to load databases, phpMyAdmin and a CLI method.

To use phpMyAdmin:
1. Using a web browser, navigate to `http://docker.test:8001`.
2. Select the database name in the left-hand sidebar.
3. Open the **Import** tab.
4. Follow on screen instructions to load the dump.

To use the CLI:
1. Place the dump file in the `db-backups/` folder in your project directory.
2. Using the command line, navigate to the directory containing your `docker-compose.yml`:
```shell
cd path/to/my_project
```
3. Open an interactive shell to the `db` container:
```shell
docker-compose exec db /bin/bash
```
4. If the dump is uncompressed (`*.sql`) use the following command to load it:
```shell
mysql -C $MYSQL_DATABASE < /tmp/name_of_dump.sql
```
5. If the dump is compressed, use one of the following commands:
```shell
zcat /tmp/name_of_dump.sql.gz | mysql -C $MYSQL_DATABASE       # gzip
xzcat /tmp/name_of_dump.sql.lzo | mysql -C $MYSQL_DATABASE     # xs
lzopcat /tmp/name_of_dump.sql.lzo | mysql -C $MYSQL_DATABASE   # LZO
```

## Updating Flight Deck

Like any set of Docker containers, you can update Flight Deck to the most recent version by pulling the new image from Docker Hub:

1. Using the command line, navigate to the directory containing your `docker-compose.yml`:
```shell
cd path/to/my_project
```
2. Stop Flight Deck.
3. Enter the following command to update the containers:
```shell
docker-compose pull
```
4. When finished, you can start the containers as normal.

The above will update **all** instances of Flight Deck on your system, so use with caution.

## Making commands shorter

Many of the commands involved in using Flight Deck (and Docker in general) can be very long and annoying to type in. For that reason, you can use *shell aliases* to create shorter versions of the commands.

On macOS and Linux:
1. Using a text editor of your choice, edit the `.bashrc`, or `.bash_profile` file in your home directory.
2. Add the following at the end of the file:
```shell
alias docup='docker-compose pull && docker-compose up -d && docker-compose exec web /bin/bash'
alias docweb='docker-compose exec web /bin/bash'
alias docdb='docker-compose exec db /bin/bash'
alias dockill='docker-compose kill'
```
3. Save the file.

Once saved you can use the alias in place of the longer command. To update, start, and open an interactive shell, use `docup`:
```shell
cd path/to/my_project
docup
```