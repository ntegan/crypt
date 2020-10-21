#!/bin/bash
openssl="/home/$USER/.local/lib/encrypt.openssl"
ENCRYPT_FILE="$1"


function encrypt {
    $openssl enc \
        -e \
        -a \
        -aes-256-cbc \
        -md sha512 \
        -pbkdf2 \
        -iter 100000 \
        -salt \
        -in "$1" -out "$1".enc
}
function decrypt {
    #$openssl enc -d -a -aes256 -in "$1".enc -out "$1".dec
    $openssl enc \
        -d \
        -a \
        -aes-256-cbc \
        -md sha512 \
        -pbkdf2 \
        -iter 100000 \
        -salt \
        -in "$1" -out "${1/.enc/}".dec
}
USAGE=$(cat <<\EOF
usage:  encrypt <filename>
            encrypts given file and appends '.enc'
        decrypt <filename.enc>
            decrypts given file and changes '.enc' to '.dec'
EOF
)

test "$#" != 1 && echo "$USAGE" && exit -1
test "$(basename "$0")" = "encrypt" && encrypt "$1"
test "$(basename "$0")" = "decrypt" && decrypt "$1"


