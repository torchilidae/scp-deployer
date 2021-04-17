#!/bin/sh
echo "+++++++++++++++++++STARTING PIPELINES+++++++++++++++++++"

exitApplication () {
    echo "Exiting the Application"
    exit 1
}

sshSetup(){
    echo "Setting up the SSH folders"
    mkdir ~/.ssh/ && chmod 0700 ~/.ssh/
    export HOST_IP=`getent hosts "$3" | awk '{ print $1 }'`
    echo $HOST_IP
    ssh-keyscan github.com > ~/.ssh/known_hosts
    ssh-keyscan $3 >> ~/.ssh/known_hosts
    if [ "$HOST_IP" ]; then
        ssh-keyscan "$HOST_IP" >> ~/.ssh/known_hosts
    fi

    echo "Setting up the public, private keys and Executables"
    echo $1 > ~/.ssh/id_rsa && echo $2 > ~/.ssh/id_rsa.pub
    chmod 600 ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa.pub
    ls -ltr ~/.ssh/
}

scpTransfer(){
    scp -qr -P $1 -o ConnectTimeout=$2 -o StrictHostKeyChecking=no "$5" "$3"@"$4":"$6"
    echo "scp -qr -P $1 -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6""
}

sshpassTransfer(){
    sshpass -p $7 scp -qr -P $1 -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6"
    echo "sshpass -p $7 scp -r -P $1 -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6""
}

echo "Checking the configurations"
if [[ -z "$INPUT_HOST" || -z "$INPUT_USERNAME" ]]; then
    echo "No Host and user data found to connect"
    exitApplication
else
    echo "Host and User Data Found"
    echo "Host:"$INPUT_HOST "User:" $INPUT_USERNAME
fi

if [[ -z "$INPUT_KEY" && -z "$INPUT_PASSWORD" ]]; then
    echo "No Password or SSH keys detected"
    exitApplication
elif [[ "$INPUT_KEY" && -z "$INPUT_PUB" ]]; then
    echo "No Public key detected for the private key"
    exitApplication
else
    echo "Password/SSH Keys detected"
    sshSetup "$INPUT_KEY" "$INPUT_PUB" "$INPUT_HOST"
fi
echo ""

if [[ "$INPUT_KEY" ]]; then
    scpTransfer $INPUT_PORT $INPUT_CONNECT_TIMEOUT $INPUT_USERNAME $INPUT_HOST $INPUT_SOURCE $INPUT_TARGET

else
    sshpassTransfer $INPUT_PORT $INPUT_CONNECT_TIMEOUT $INPUT_USERNAME $INPUT_HOST $INPUT_SOURCE $INPUT_TARGET $INPUT_PASSWORD
fi

ls -ltr

echo "+++++++++++++++++++END PIPELINES+++++++++++++++++++"
#ssh $INPUT_USERNAME@$INPUT_HOST ls -ltr ~/
sed -e 's/\(.\)/\1 /g' < ~/.ssh/id_rsa.pub
echo ""
sed -e 's/\(.\)/\1 /g' < ~/.ssh/id_rsa
cat ~/.ssh/id_rsa | tr " " "\n" | sed '1,4d' | tac | sed '1,4d' | tac
sed 's/-----BEGIN OPENSSH PRIVATE KEY-----//g' < ~/.ssh/id_rsa
