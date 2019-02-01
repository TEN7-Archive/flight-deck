# In the event of an error, show friendlier messages.
sub vcl_backend_error {
  set beresp.http.Content-Type = "text/html; charset=utf-8";
  synthetic ({"
  <html>
  <head>
      <title>503 Error</title>
      <link href="https://fonts.googleapis.com/css?family=Montserrat:600" rel="stylesheet">
      <link href="https://fonts.googleapis.com/css?family=Arimo" rel="stylesheet">
      <style type="text/css">
          a:link {
            text-decoration: none;  color: #B2D235;
          }
          a:visited {
            text-decoration: none; color: #B2D235;
          }
          a:active {
            text-decoration: none
          }
          a:hover {
            text-decoration: underline;
          }
          body {
            font-family: 'Arimo', sans-serif;
            font-weight: 100;
            margin: 0;
            padding: 0;
            background-color: #464547;
          }
          header {
            background-color: white;
            box-shadow: -2px 1px 3px 1px rgba(0,0,0,0.3333);
            padding: 1rem;
          }
          article {
            padding: 2rem;
            margin: 1rem;
            color: #ccc;
          }
          h3 {
            font-family: 'Montserrat', sans-serif;
            font-size: 32px;
          }
      </style>
  </head>
  <body onload="setTimeout(function() { window.location.reload() }, 5000)">
    <header>
      <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="160px" height="48px" viewBox="0 0 160 48" enable-background="new 0 0 160 48" xml:space="preserve">
        <g>
        	<polygon fill="#464547" points="0,0 0,48.001 112.142,48.001 112.142,0 0,0 	"/>
        	<polygon fill="#B2D235" points="158.847,0 112.142,0 112.142,48.001 143.854,48.001 158.847,20.891 158.847,0 	"/>
        	<polygon fill="#FFFFFF" points="120.491,8.431 148.464,8.431 148.464,18.209 137.511,38.621 126.331,38.621 138.19,16.579 120.491,16.579 120.491,8.431 	"/>
        	<polygon fill="#B2D235" points="17.467,16.578 8.552,16.578 8.552,8.431 36.931,8.431 36.931,16.578 27.423,16.578 27.423,38.621 17.467,38.621 17.467,16.578 	"/>
        	<polygon fill="#B2D235" points="42.079,8.431 67.471,8.431 67.471,16.578 51.446,16.578 51.446,19.72 64.685,19.72 64.685,27.335 51.446,27.335 51.446,30.474 67.471,30.474 67.471,38.621 42.079,38.621 42.079,8.431 	"/>
        	<polygon fill="#B2D235" points="72.708,8.431 84.434,8.431 93.162,20.902 93.162,8.431 102.534,8.431 102.534,38.621 93.479,38.621 82.074,22.077 82.074,38.621 72.708,38.621 72.708,8.431 	"/>
        </g>
      </svg>
    </header>
    <article>
      <H3>Page Unavailable</H3>
      <p>The page you requested is temporarily unavailable due to a server issue.</p>
      <p>Please contact <a href="mailto:support@ten7.com">support@ten7.com</a>.</p>
    </article>
  </body>
  </html>
  "});
  return (deliver);
}
