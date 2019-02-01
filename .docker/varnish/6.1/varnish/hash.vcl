sub vcl_hash {
  # Varnish already hashes the host and URL, but not the protocol.
  # This can cause mixed content warnings with HTTPS.
  # So, we hash the protocol with each cache object so keep them separate.
  if (req.http.X-Forwarded-Proto) {
    hash_data(req.http.X-Forwarded-Proto);
  }
}
