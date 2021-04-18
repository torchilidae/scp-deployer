#!/bin/sh
echo "+++++++++++++++++++STARTING PIPELINES+++++++++++++++++++"

exitApplication () {
    echo "Exiting the Application"
    exit 1
}

sshSetup(){
    echo "Setting up the public, private keys and Executables"
    echo "-----BEGIN OPENSSH PRIVATE KEY-----" >> tmp_id
    echo $1 | tr " " "\n" | sed '1,4d' | tac | sed '1,4d' | tac >> tmp_id
    echo "-----END OPENSSH PRIVATE KEY-----" >> tmp_id
    echo "" >> tmp_id
}

scpTransfer(){
    scp -qr -P $1 -i tmps_id -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6"
}

sshpassTransfer(){
    sshpass -p $7 scp -qr -P $1 -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6"
}

if [[ "$INPUT_KEY" ]]; then
    scpTransfer $INPUT_PORT $INPUT_CONNECT_TIMEOUT $INPUT_USERNAME $INPUT_HOST $INPUT_SOURCE $INPUT_TARGET

else
    sshpassTransfer $INPUT_PORT $INPUT_CONNECT_TIMEOUT $INPUT_USERNAME $INPUT_HOST $INPUT_SOURCE $INPUT_TARGET $INPUT_PASSWORD
fi

ls -ltr

echo "+++++++++++++++++++END PIPELINES+++++++++++++++++++"
#ssh $INPUT_USERNAME@$INPUT_HOST ls -ltr ~/
#sed -e 's/\(.\)/\1 /g' < ~/.ssh/id_rsa.pub
#echo ""
#sed -e 's/\(.\)/\1 /g' < ~/.ssh/id_rsa
#cat ~/.ssh/id_rsa | tr " " "\n" | sed '1,4d' | tac | sed '1,4d' | tac
#sed 's/-----BEGIN OPENSSH PRIVATE KEY-----//g' < ~/.ssh/id_rsa
