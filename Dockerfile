# Node Stage
FROM node:8.16.0-jessie as node
MAINTAINER xexuew@gmail.com

WORKDIR /app
COPY . .
RUN yarn install && yarn build

# Nginx Stage
FROM nginx
RUN mkdir /app
COPY --from=node /app/dist /app
COPY Docker/nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE $PORT
# Recogemos el env PORT y lo agregamos al archivo de configuración de nginx
CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf" && nginx -g 'daemon off;'