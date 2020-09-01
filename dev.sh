#!/bin/sh

start() {
  cd laradock && docker-compose up -d mysql nginx workspace phpmyadmin "$@"
}

rebuild() {
  cd laradock && docker-compose up -d --build mysql nginx workspace phpmyadmin "$@"
}

composer() {
  cd laradock && docker-compose exec workspace php -d memory_limit=-1 /usr/local/bin/composer "$@"
}

drush() {
  cd laradock && docker-compose exec workspace /var/www/vendor/bin/drush --root="/var/www" "$@"
}

bash() {
  cd laradock && docker-compose exec workspace bash
}

root() {
  cd laradock && docker-compose exec --user root workspace bash
}


# Setup the project for development
install() {
  LARADOCK_DEFAULT_ENV_FILE=environment-preset/.env.laradock
  LARADOCK_ENV_FILE=laradock/.env
  DRUPAL_DEFAULT_SETTINGS_FILE=sites/default/default.settings.php
  DRUPAL_SETTINGS_FILE=sites/default/settings.php
  NGINX_DEFAULT_CONFIG_FILE=environment-preset/nginx.example
  NGINX_CONFIG_FILE=laradock/nginx/sites/default.conf

  # Create laradock .env file
  if test -f "$LARADOCK_ENV_FILE"; then
    echo "$LARADOCK_ENV_FILE already exists."
  else
    echo "$LARADOCK_ENV_FILE does not exist."
    echo "Copying $LARADOCK_DEFAULT_ENV_FILE to $LARADOCK_ENV_FILE"
    cp $LARADOCK_DEFAULT_ENV_FILE $LARADOCK_ENV_FILE
  fi

  if test -f "$DRUPAL_SETTINGS_FILE"; then
    echo "$DRUPAL_SETTINGS_FILE already exists."
  else
    echo "$DRUPAL_SETTINGS_FILE does not exist."
    echo "Copying $DRUPAL_DEFAULT_SETTINGS_FILE to $DRUPAL_SETTINGS_FILE"
    cp $DRUPAL_DEFAULT_SETTINGS_FILE $DRUPAL_SETTINGS_FILE
  fi

  if test -f "$NGINX_CONFIG_FILE"; then
    echo "$NGINX_CONFIG_FILE already exists."
  else
    echo "$NGINX_CONFIG_FILE does not exist."
    echo "Copying $NGINX_DEFAULT_CONFIG_FILE to $NGINX_CONFIG_FILE"
    cp $NGINX_DEFAULT_CONFIG_FILE $NGINX_CONFIG_FILE
  fi
}

"$@"
