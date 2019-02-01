vcl 4.0;

import std;

include "/etc/varnish/backend.vcl";
include "/etc/varnish/acl.vcl";
include "/etc/varnish/recv.vcl";
include "/etc/varnish/deliver.vcl";
include "/etc/varnish/hit.vcl";
include "/etc/varnish/hash.vcl";
include "/etc/varnish/beresp.vcl";
include "/etc/varnish/pipe.vcl";
include "/etc/varnish/beerr.vcl";
