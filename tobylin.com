server {
        listen 80;
        listen [::]:80;

        root /home/zikunlin/www/tobylin.com;

        index index.html;

        server_name tobylin.com www.tobylin.com;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }
}
