## Description
This is very basic and easy installer to create fresh Symfony 4 installation with Docker usage.

PHP Docker image contains basic tools like:
- composer
- yarn
- phpstan
- php-cs-fixer

Additionally installation contains Makefile to easy run basic commands without entering into docker containers.

### Warning!
This stack shouldn't be used on production!

## Requirements
- `docker`
- `docker-compose`
- `wget`
- `make`

## Instalation

```
wget https://raw.githubusercontent.com/devs-php/symfony4-dock-template/master/install.sh
chmod +x install.sh
./install.sh
```
