#!/bin/sh
echo "+++++++++++++++++++STARTING SCP TRANSFER+++++++++++++++++++"

if [[ "$INPUT_KEY" ]]; then
    echo -e "${INPUT_KEY}" > tmp_id
    chmod 600 tmp_id
    ls -ltr
    scp -qr -P $INPUT_PORT -o StrictHostKeyChecking=no -i tmp_id $INPUT_SOURCE "$INPUT_USERNAME"@"$INPUT_HOST":"$INPUT_TARGET"
    echo "Transfer process complete using SSH keys"
else
    echo "Trying password authentication as key is not available"
    sshpass -p $INPUT_PASSWORD scp -qr -P $INPUT_PORT -o StrictHostKeyChecking=no $INPUT_SOURCE "$INPUT_USERNAME"@"$INPUT_HOST":"$INPUT_TARGET"
    echo "Transfer process complete using password"
fi

echo "+++++++++++++++++++END+++++++++++++++++++"
