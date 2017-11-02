# Xdebug

Dockstack may be configured to support Xdebug, an open source PHP debugger. Using a debugger makes a world of difference if you've been using `print` statements to get your code working.

## Enabling Xdebug

For performance reasons, Xdebug is *not* enabled out of the back in Dockstack. Fortunately, it only takes a few minutes to configure.

1. Using the `docker` or `docker-compose` commands, kill your currently running instance of Dockstack.
2. Open the `.env` file in your favorite text editor.
3. Scroll to the Xdebug section, and follow instructions in the file to enable.
4. Note that Docker for macOS and Docker for Windows will not work without some additional configuration. See the `.env` file for details.
5. (Re)start Dockstack using `docker-compose up -d`.

## Verification

To verify that Xdebug is working, you will need to visit a page displaying `phpinfo()`. If using Dockstack with Drupal, you can do the following:

1. Login to the drupal site.
2. Navigate to `admin/reports/status/php`.
3. Validate that the `xdebug` module is loaded in the page output.

## Setting the IDE Key

Xdebug uses an "IDE key" to identify if you are attempting to debug a page. To make setting this parameter easier, you can install a web browser extension:

* Google Chrome: [Xdebug helper](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc?hl=en)
* Mozilla Firefox: [The easiest Xdebug](https://addons.mozilla.org/en-US/firefox/addon/the-easiest-xdebug)

By default, Dockstack expects the IDE key to be `PHPSTORM`. Be sure to set it in the extension preferences.

## Configuring PHPStorm

### Path mapping

Even though Dockstack is running on your local machine, you need to treat it as if it was a completely separate, physical machine elsewhere on the network. For this reason, you need to configure PHPStorm to map file paths on your local machine to those inside the containers.

First we need to create a new Debug configuration. You only have to do that once per project.

1. Using the **Run** menu, select **Edit configurations**.
2. The **Run/Debug Configurations** window appears. Click the **+** icon in the upper left corner, and select **PHP Remote Debug**.
3. Enter a unique **Name**.
4. Click **Apply** to save your changes.

Next, we need to configure the remote server.

1. Open the **Run/Debug Configurations** window, and the debug configuration you created earlier.
2. Click the **...** button next to **Servers**.
3. The **Servers** window appears. Click the **+** icon in the upper left corner to create a new server.
4. Enter a unique **Name** for the server. Usually this is the same as your URL alias (`docker.local`).
5. Enter the **Host** as the same as your URL alias.
6. Select the **Debugger** as **Xdebug**.
7. Select **Use path mappings**.
8. In the path mappings table, locate the `src` directory. Enter the **Absolute path on the server** as `/var/www/html`.
9. Click **OK** to save your changes.

### Linux hosts

Linux hosts have two ways they may configure Xdebug support.
* If your `.env` isn't shared between multiple, mixed-OS team members, follow the instructions to use  `PHP_XDEBUG_REMOTE_CONNECT_BACK`.
* If your `.env` **is** shared, you can define a loopback alias (see the `.env` file for an example). Once finished, continue to the next section.

### macOS and Windows hosts

In order for PHPStorm to pick up the remote debugging session, you need to configure the DBGp Proxy:

1. Open the PHPStorm preferences.
2. Navigate to **Languages & Frameworks &gt; PHP &gt; Debug &gt; DBG Proxy**.
3. Set the **IDE key** as `PHPSTORM`.
4. Set the **Host** to the value of `PHP_XDEBUG_REMOTE_HOST` in your `.env` file.
5. Set the **Port** to the Xdebug default, `9000`.
6. Click **OK** to save your changes.

## Logging and Troubleshooting

By default, Dockstack stores Xdebug logs at `/var/log/apache2/xdebug.log`. If you ever need to troubleshoot the Xdebug configuration is may be useful to redirect the logs to STDOUT, this makes the logs available with a `docker-compose logs` command.

To enable Xdebug logging to STDOUT:

1. Open the `.env` file for editing.
2. Uncomment the `PHP_XDEBUG_STDOUT_LOGS` setting, be sure it's set to a value of `1`.
3. Stop and restart Dockstack.
4. Use `docker-compose logs` to view the container logs.

When interacting with the **web** container using `docker-compose exec`, you may see the output of Xdebug in your terminal window. This is normal, if annoying, when `PHP_XDEBUG_STDOUT_LOGS` is enabled.
