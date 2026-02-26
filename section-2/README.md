# Task A - 502 Bad Gateway (Nginx + Node.js)

## To reproduce:
1. Create simple nodejs + express server
2. Containerize it, expose port 3000 in the container
3. Create and Nginx image
4. Create Nginx configuration that listens on the port 80 and redirects traffic to the port 8080
5. Start the configuration with $ docker compose up and open localhost:80

## To fix it:
1. The HTTP 502 Bad Gateway server error response status code indicates that a server was acting as a gateway or proxy and that it received an invalid response from the upstream server. [https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status/502]
2. Since we know we are using an Nginx as a server proxy, we can investigate further configuration file
3. In the configuration file we can see that proxy_pass proxies to http://web:8080. 
4. But our nodejs server is exposed via port 3000, so we route traffic to the port 8080 that is not exposed, 
   resulting in an error
5. To fix it, we need to properly proxy requests to the port 3000 inside the given configuration file

## Prevention
1. To prevent accidents like this in the future, we can enforce communication with the server only via the proxy.
   This way, if configuration is not properly done, issues will be visible immediately.
2. To do this, we need to change the port option for web inside the compose.yaml to the expose.
3. The expose option exposes port only to the compose network, host wont be able to connect directly to the web.

# Commands
$ docker compose up