FROM nginx:latest

ADD ./laravelVHost.conf /etc/nginx/conf.d/default.conf
WORKDIR /var/www