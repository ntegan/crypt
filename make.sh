LIB=/home/$USER/.local/lib
BIN=/home/$USER/.local/bin
function install {
    # get openssl
    git submodule init
    git submodule update

    # Compile openssl
    cd openssl
    ./config no-shared
    num_cpus=$(nproc)
    make -j$((num_cpus - (num_cpus / 3)))
    cp apps/openssl ../encrypt.openssl
    cd ..
    git submodule deinit -f openssl

    mkdir -p $LIB
    mkdir -p $BIN

    mv encrypt.openssl $LIB
    cp encrypt.sh $LIB
    ln -s $LIB/encrypt.sh $BIN/encrypt
    ln -s $LIB/encrypt.sh $BIN/decrypt
}

function uninstall {
    rm -f $LIB/{encrypt.sh,encrypt.openssl}
    rm -f $BIN/{encrypt,decrypt}
}





test "$1" = "install" && install
test "$1" = "uninstall" && uninstall

