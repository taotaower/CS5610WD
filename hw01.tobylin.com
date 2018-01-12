server {
        listen 80;
        listen [::]:80;

        root /home/zikunlin/www/tobylin.com;

        index screenshot.html;

        server_name hw01.tobylin.com;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }
}
