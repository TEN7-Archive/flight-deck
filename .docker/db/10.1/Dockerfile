FROM alpine:3.9
MAINTAINER tess@ten7.com

# Update the package list and install Ansible.
RUN apk -U upgrade &&\
    apk add --update --no-cache ansible && \
    rm -rf /tmp/* \
           /var/cache/apk/* \
           /usr/lib/python3.6/site-packages/ansible/modules/network/ \
           /usr/lib/python3.6/site-packages/ansible/modules/cloud/ \
           /usr/lib/python3.6/site-packages/ansible/modules/windows/

# Copy the Ansible configuration files
COPY ansible-hosts /etc/ansible/hosts
COPY ansible.cfg /etc/ansible/ansible.cfg
COPY ansible /ansible

# Run the build playbook
RUN ansible-playbook -i /ansible/inventories/all.ini /ansible/build.yml 

# Configure the runtime environment of the container.
VOLUME /var/lib/mysql
WORKDIR /var/lib/mysql
EXPOSE 3306

# Switch to the mysql user.
USER mysql

# Set the entrypoint and default command.
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld_safe", "--user=mysql", "--console"]
