#!/bin/sh
echo "+++++++++++++++++++STARTING PIPELINES+++++++++++++++++++"

echo "Checking the configurations"
if [ -z "$HOST" || -z "$USER" ]; then
    echo "No Host found to connect"
    echo "Exiting the Application"
    echo "Trying uppercase"
    echo $HOST
    echo "Trying lower case"
    echo $host
    exit 1
fi
echo ""

echo "Setting up the SSH folders"
mkdir ~/.ssh/ && chmod 0700 ~/.ssh/
ssh-keyscan github.com > ~/.ssh/known_hosts
echo ""

echo "Setting up the public, private keys and Executables"
echo $KEY > ~/.ssh/id_rsa && echo $PUB > ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa.pub
touch /scp-deployer.sh && chmod 700 /scp-deployer.sh
echo ""
echo "+++++++++++++++++++END PIPELINES+++++++++++++++++++"
