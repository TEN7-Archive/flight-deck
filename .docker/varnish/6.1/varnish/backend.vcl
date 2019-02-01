
# This is a basic VCL configuration file for varnish.  See the vcl(7)
# man page for details on VCL syntax and semantics.
#
# Default backend definition.  Set this to point to your content
# server.
backend default {
  .host = "VARNISH_BACKEND_HOST";
  .port = "VARNISH_BACKEND_PORT";

  # .probe = {
  #    # We use .request instead of .url because we need to force-set a valid
  #    # URL to Apache. If we don't, Varnish will mark it has sick and 503.
  #    .request =
  #    "HEAD / HTTP/1.1"
  #    "Host: VARNISH_BACKEND_HOST"
  #    "Connection: close";
  #
  #    # How often to check the backend health.
  #   .interval  = 15s;
  #
  #   # How long to wait on each individual check.
  #   .timeout   = 5s;
  #
  #   # If .threshold checks fail of the last .window times, mark the BE as sick.
  #   .threshold = 3;
  #   .window    = 5;
  # }

  .first_byte_timeout     = 300s;
  .connect_timeout        = 5s;
  .between_bytes_timeout  = 2s;
}
