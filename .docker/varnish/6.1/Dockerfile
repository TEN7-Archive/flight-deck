FROM alpine:3.9
MAINTAINER tess@ten7.com

# Create a service user with the home directory.
RUN adduser -g varnish -D -h /var/lib/varnish varnish && \
    mkdir -p -m 774 /var/lib/varnish && \
    chown varnish:varnish -R /var/lib/varnish

# Update all the Alpine packages.
RUN apk -U upgrade

# Install Apache and PHP.
RUN apk add --update --no-cache \
            ansible \
            bash \
            varnish

# Copy the Varnish configuration files.
COPY varnish /etc/varnish/

# Set the owner of the /etc/varnish directory.
RUN chown -R varnish:varnish /etc/varnish

# Copy various key scripts to a directory in $PATH.
COPY docker-entrypoint.sh /usr/local/bin/
COPY varnish-foreground.sh /usr/local/bin/

# Make them all executable.
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh \
              /usr/local/bin/varnish-foreground.sh

# Copy the entire contents of the init.d directory.
COPY docker-entrypoint-init.d /docker-entrypoint-init.d
RUN chmod a+x -R /docker-entrypoint-init.d

# Copy the root bashrc file.
COPY bashrc-root /root/.bashrc

# Copy the Ansible configuration files
COPY ansible-hosts /etc/ansible/hosts
COPY ansible.cfg /etc/ansible/ansible.cfg

# Change to the Varnish user.
USER varnish

# Copy the user bashrc file.
COPY bashrc-user /var/lib/varnish/.bashrc

# Expose the default varnish port and control port.
EXPOSE 6081 6082

# Set the entrypoint and default command.
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["varnish-foreground.sh"]
