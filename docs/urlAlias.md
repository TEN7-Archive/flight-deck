# Creating a URL alias

Accessing Dockstack using `localhost` poses a number of problems. The biggest of which is that it's a special domain name, which creates problems for complex CMSes like Drupal. Many sites also rely on `.htaccess` rewrite rules to redirect traffic to an HTTPS or `www.`-prefixed domain.

To solve these issues, it's ***highly*** recommended to create a *URL alias*.

## Linux and macOS

On Linux and macOS, creating the URL alias is easy:

1. Open a terminal emulator.
2. Open the `/etc/hosts` file using your favorite text editor. Be sure to use `sudo` to run the command as the root user: `sudo vi /etc/hosts`
3. Notice there are two columns of text, one is IP address, the other is host names.
4. At the end of the file, enter a new row. Use `127.0.0.1` as the IP address, and `docker.dev` as the hostname.

## Windows

The Hosts file on Windows is actually in the same format as Linux and macOS, but it's in a different location.

1. Using the Start Menu, locate the **Notepad** application.
2. Right click **Notepad**, and select **Run as administrator**.
3. Open the following file for editing: `C:\Windows\System32\Drivers\etc\hosts`
4. Notice there are two columns of text, one is IP address, the other is host names.
5. At the end of the file, enter a new row. Use `127.0.0.1` as the IP address, and `docker.dev` as the hostname.

## Additional aliases

You only need to create the `docker.dev` alias once, no matter how many Dockstack-powered projects you have on your system. You may also choose to add a different URL alias such as 'docker.local', '[your_site_name].dev', and so on.
