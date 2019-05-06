acl purge {
  "localhost";
  "127.0.0.1";
  "::1";
  "VARNISH_BACKEND_HOST";
}


# List of upstream proxies we trust to set X-Forwarded-For correctly.
acl upstream_proxy {
}
