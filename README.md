# Laradock <3 Drupal 8

## Good to know
Laradock is a full PHP development environment for Docker.

It supports a variety of common services, all pre-configured to provide a ready PHP development environment.

## Installation

1. Clone the project to a location of your choice.
```
git clone --recursive git@github.com:erhuz/drupal8-with-laradock.git
```

2. Make the dev.sh file executable
```
sudo chmod +x /path/to/dev.sh
```

3. Setup project by running:
```
dev.sh install
```

4. Configure parameters in `laradock/.env` such as `WORKSPACE_PUID` and `WORKSPACE_GUID`. (Workspace is the container you'll be working inside)

5. Setup the database in `sites/default/settings.php`. Read the example comments in the file to know how.

6. Run `/path/to/dev.sh start` to start the containers.
