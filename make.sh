set -euxo pipefail
LIB=/home/$USER/.local/lib
BIN=/home/$USER/.local/bin

function install {
    # get openssl (git submodule)
    git submodule init
    git submodule update

    # Compile openssl
    cd openssl
    ./config no-shared
    num_cpus=$(nproc)
    make -j$((num_cpus - (num_cpus / 3)))
    cp apps/openssl ../encrypt.openssl

    # don't need openssl source/repo anymore
    cd ..
    git submodule deinit -f openssl

    # Make install directories if user doesn't already have them
    # I think mine were installed from python pip packages
    # TODO: make sure user has bin on their path (for `encrypt` and `decrypt`)
    mkdir -p $LIB
    mkdir -p $BIN

    # install
    mv encrypt.openssl $LIB
    cp encrypt.sh $LIB
    ln -s $LIB/encrypt.sh $BIN/encrypt
    ln -s $LIB/encrypt.sh $BIN/decrypt
}

function uninstall {
    rm -f $LIB/{encrypt.sh,encrypt.openssl}
    rm -f $BIN/{encrypt,decrypt}
}


if test "$1" = "install"; then
    install
elif test "$1" = "uninstall"; then
    uninstall
fi

