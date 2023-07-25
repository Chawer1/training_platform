
# Training App

The details of configuring and installing the various configurations will be described here

## Establish dependencies
*Run locally*:

Update the package index

```bash
sudo apt-get update
```

Install dependencies

```bash
sudo apt install git curl libssl-dev libreadline-dev 
zlib1g-dev autoconf bison build-essential libyaml-dev 
libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
```

[Install rbenv using GitHub](https://github.com/rbenv/rbenv)

Install Ruby
```bash
rbenv install 3.0.2
rbenv global 3.0.2
```

Install Bundler
```bash
gem install bundler
```
## Docker installation
Make sure you have Docker version 24.0.4 and Docker Compose version 1.29.2 installed on your system.

[Documentation](https://docs.docker.com/desktop/install/ubuntu)


## Сonfiguration

config/database.yml => *change data*

## Docker run
*Run in the project root folder*

Install gems

```bash
  bundle
```

Build the images

```bash
  sudo docker-compose build
```

Start containers

```bash
  sudo docker-compose up
```

