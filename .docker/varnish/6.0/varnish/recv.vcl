# Respond to incoming requests.
sub vcl_recv {

  if (req.method == "PURGE") {
    if (!client.ip ~ purge) {
      return(synth(405,"Purge not allowed."));
    }

    return (purge);
  }

  if (req.method == "BAN") {
    if (!client.ip ~ purge) {
      return(synth(405, "Ban not allowed."));
    }

    # Some examples also set an internal x-host and x-url in the req,
    # then key off of it here for the ban.
    ban("req.http.host ~ " + req.http.x-ban-host +
          " && req.url ~ " + req.http.x-ban-url);

    # Throw a synthetic page so the
    # request won't go to the backend.
    return(synth(200, "Ban added"));
  }

  # Pass the X-Forwarded-For IP, if any. Otherwise use the upstream proxy IP.
  if (client.ip ~ upstream_proxy && req.http.X-Forwarded-For) {
    set req.http.X-Forwarded-For = req.http.X-Forwarded-For;
  } else {
    set req.http.X-Forwarded-For = regsub(client.ip, ":.*", "");
  }

  # Protecting against the HTTPOXY CGI vulnerability.
  unset req.http.proxy;

  # Set the grace custom header to "none", it may be overriden in vcl_hit().
  set req.http.grace = "none";

  # Deal with GET and HEAD  requests only, everything else gets through
  if (req.method != "GET" &&
      req.method != "HEAD") {
    return (pass);
  }

  # Do not cache these paths.
  if (req.url ~ "^/status\.php$" ||
      req.url ~ "^/update\.php" ||
      req.url ~ "^/install\.php" ||
      req.url ~ "^/apc\.php$" ||
      req.url ~ "^/admin" ||
      req.url ~ "^/admin/.*$" ||
      req.url ~ "^/user" ||
      req.url ~ "^/user/.*$" ||
      req.url ~ "^/users/.*$" ||
      req.url ~ "^/info/.*$" ||
      req.url ~ "^/flag/.*$" ||
      req.url ~ "^.*/ajax/.*$" ||
      req.url ~ "^.*/ahah/.*$" ||
      req.url ~ "^/system/files/.*$") {

      return (pass);
  }

  # Removing cookies for static content so Varnish caches these files.
  if (req.url ~ "(?i)\.(pdf|asc|dat|txt|doc|xls|ppt|tgz|csv|png|gif|jpeg|jpg|ico|swf|css|js|svg)(\?.*)?$") {
      unset req.http.Cookie;
  }

  # Remove all cookies that Drupal doesn't need to know about. We explicitly
  # list the ones that Drupal does need, the SESS and NO_CACHE. If, after
  # running this code we find that either of these two cookies remains, we
  # will pass as the page cannot be cached.
  if (req.http.Cookie) {
    # 1. Append a semi-colon to the front of the cookie string.
    set req.http.Cookie = ";" + req.http.Cookie;

    # 2. Remove all spaces that appear after semi-colons.
    set req.http.Cookie = regsuball(req.http.Cookie, "; +", ";");

    # 3. Match the cookies we want to keep, adding the space we removed
    #    previously back. (\1) is first matching group in the regsuball.
    set req.http.Cookie = regsuball(req.http.Cookie, ";(SESS[a-z0-9]+|SSESS[a-z0-9]+|NO_CACHE|XDEBUG_SESSION)=", "; \1=");

    # 4. Remove all other cookies, identifying them by the fact that they have
    #    no space after the preceding semi-colon.
    set req.http.Cookie = regsuball(req.http.Cookie, ";[^ ][^;]*", "");

    # 5. Remove all spaces and semi-colons from the beginning and end of the
    #    cookie string.
    set req.http.Cookie = regsuball(req.http.Cookie, "^[; ]+|[; ]+$", "");

    if (req.http.Cookie == "") {
      # If there are no remaining cookies, remove the cookie header. If there
      # aren't any cookie headers, Varnish's default behavior will be to cache
      # the page.
      unset req.http.Cookie;
    }
    else {
      # If there is any cookies left (a session or NO_CACHE cookie), do not
      # cache the page. Pass it on to Apache directly.
      return (pass);
    }
  }
}
