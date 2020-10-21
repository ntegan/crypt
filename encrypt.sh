#!/bin/bash
openssl="/home/$USER/.local/lib/encrypt.openssl"
ENCRYPT_FILE="$1"
OPENSSL_ENCRYPTION_OPTIONS=""
OPENSSL_ENCRYPTION_OPTIONS+=" -a "
OPENSSL_ENCRYPTION_OPTIONS+=" -aes-256-cbc "
OPENSSL_ENCRYPTION_OPTIONS+=" -md sha512 "
OPENSSL_ENCRYPTION_OPTIONS+=" -pbkdf2 "
OPENSSL_ENCRYPTION_OPTIONS+=" -iter 100000 "
OPENSSL_ENCRYPTION_OPTIONS+=" -salt "


function encrypt {
    $openssl enc \
        -e \
        $OPENSSL_ENCRYPTION_OPTIONS \
        -in "$1" -out "$1".enc
}
function decrypt {
    $openssl enc \
        -d \
        -a \
        $OPENSSL_ENCRYPTION_OPTIONS \
        -in "$1" -out "${1/.enc/}".dec
    return 0
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
