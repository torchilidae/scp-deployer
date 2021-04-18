#!/bin/sh
echo "+++++++++++++++++++STARTING PIPELINES+++++++++++++++++++"

#sshSetup(){
#    echo "Setting up the public, private keys and Executables"
#    echo "-----BEGIN OPENSSH PRIVATE KEY-----" >> tmp_id
#    echo $1 | tr " " "\n" | sed '1,4d' | tac | sed '1,4d' | tac >> tmp_id
#    echo "-----END OPENSSH PRIVATE KEY-----" >> tmp_id
#    echo "" >> tmp_id
#}

#scpTransfer(){
#    scp -qr -P $1 -i tmps_id -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6"
#}
#
#sshpassTransfer(){
#    sshpass -p $7 scp -qr -P $1 -o ConnectTimeout=$2 "$5" "$3"@"$4":"$6"
#}

echo -e "${INPUT_KEY}" > tmpid
chmod 600 tmpid

if [[ "$INPUT_KEY" ]]; then
    scp -qr -P $INPUT_PORT -o ConnectTimeout=$INPUT_CONNECT_TIMEOUT -o StrictHostKeyChecking=no -i tmpid $INPUT_SOURCE "$INPUT_USERNAME"@"$INPUT_HOST":"$INPUT_TARGET"
else
    echo ""
    #sshpassTransfer $INPUT_PORT $INPUT_CONNECT_TIMEOUT $INPUT_USERNAME $INPUT_HOST $INPUT_SOURCE $INPUT_TARGET $INPUT_PASSWORD
fi

ls -ltr

echo "+++++++++++++++++++END PIPELINES+++++++++++++++++++"
