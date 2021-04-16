#!/bin/sh
echo "+++++++++++++++++++STARTING PIPELINES+++++++++++++++++++"

exitApplication () {
    echo "Exiting the Application"
    exit 1
}

sshSetup(){
    echo "Setting up the SSH folders"
    mkdir ~/.ssh/ && chmod 0700 ~/.ssh/
    ssh-keyscan github.com > ~/.ssh/known_hosts

    echo "Setting up the public, private keys and Executables"
    echo "$1" > ~/.ssh/id_rsa && echo "$2" > ~/.ssh/id_rsa.pub
    chmod 600 ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa.pub
    touch /scp-deployer.sh && chmod 700 /scp-deployer.sh  
}

scpTransfer(){
    scp -qr -P $1 -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6"
    echo "scp -qr -P $1 -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6""
}

sshpassTransfer(){
    sshpass -p $7 scp -qr -P $1 -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6"
    echo "sshpass -p $7 scp -r -P $1 -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6""
}

echo "Hostname: "$HOST

echo "Checking the configurations"
if [[ -z "$HOST" || -z "$USERNAME" ]]; then
    echo "No Host and user data found to connect"
    exitApplication
else
    echo "Host and User Data Found"
    echo "Host:"$HOST "User:" $USERNAME
fi

if [[ -z "$KEY" || -z "$PASSWORD" ]]; then
    echo "No Password or SSH keys detected"
    exitApplication
elif [[ "$KEY" && -z "$PUB" ]]; then
    echo "No Public key detected for the private key"
    exitApplication
else
    echo "Password/SSH Keys detected"
    sshSetup "$KEY" "$PUB"
fi
echo ""

if [[ "$KEY" ]]; then
    scpTransfer $PORT $CONNECT_TIMEOUT $USERNAME $HOST $SOURCE $TARGET

else
    sshpassTransfer $PORT $CONNECT_TIMEOUT $USERNAME $HOST $SOURCE $TARGET $PASSWORD
fi

echo "+++++++++++++++++++END PIPELINES+++++++++++++++++++"
