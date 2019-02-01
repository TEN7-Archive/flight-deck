
# Set a header to track a cache HITs and MISSes.
sub vcl_deliver {
  # Remove ban-lurker friendly custom headers when delivering to client.
  unset resp.http.X-Url;
  unset resp.http.X-Host;
  unset resp.http.Cache-Tags;
  # Remove some headers
  unset resp.http.Via;
  if (obj.hits > 0) {
    set resp.http.X-Varnish-Cache = "HIT";
    set resp.http.X-Cache-Hits = obj.hits;
  }
  else {
    set resp.http.X-Varnish-Cache = "MISS";
  }

  # Pass the grace mode header to the client
  set resp.http.grace = req.http.grace;
}
