#!/bin/bash

command -v docker >/dev/null 2>&1 || {
    echo >&2 -e "\e[91mDocker not installed. Aborting.";
    exit 1;
}

echo -e "\e[33mWhere to install new Symfony 4 project?\e[39m "
read -p "Path: " path </dev/tty

if [[ -e ${path} || -d ${path} ]]; then
    echo >&2 -e "\e[91mDirectory exists or path empty. Aborting.";
    exit 1;
fi

path=$(realpath ${path})
read -p "Do you want install in: ${path} (Yn)" confirm </dev/tty
confirm=${confirm:-"Y"}
if [[ "${confirm,,}" != "y" ]]; then
    echo >&2 -e "\e[91mAborting.";
    exit 1;
fi

echo "Creating directory"
mkdir -p ${path}

echo "Installing Symfony"
tty=
tty -s && tty=--tty
docker run ${tty} --interactive --rm \
    --user $(id -u):$(id -g) \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume ${path}:/app \
    composer create-project symfony/skeleton .

echo "Fetching docker skeleton files"
wget -nv -O - https://api.github.com/repos/devs-php/symfony4-dock-scetch/tarball | \
    tar xzf - -C "${path}/" \
    --exclude=install.sh --exclude=LICENSE.md --exclude=README.md \
    --strip-components=1

cd ${path}
read -p "Boot application? (yN)" confirm </dev/tty
confirm=${confirm:-"N"}
if [[ "${confirm,,}" == "n" ]]; then
    echo >&2 -e "To boot application run \e[32mdocker-compose up -d";
    exit 1;
fi

docker-compose up -d
