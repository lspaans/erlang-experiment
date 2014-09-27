#!/bin/sh
#
# deploy.sh: Idempotent script for the installatie of 'erlang-experiment'
# on Vagrant
#

set -e

install_packages () {
    while [ $# -ne 0 ] ; do
        if [ -e /usr/share/doc/"$1" ] ; then
            printf 'Package already installed: %s\n' "$1" >&2
            shift
        else
            apt-get -y install "$@"
            break
        fi
    done
}

install_script () {
    SCRIPT=/usr/local/bin/"$1"
    printf "Installing %s...\n" "$SCRIPT" >&2
    cat > "$SCRIPT"
    chmod 755 "$SCRIPT"
}

install_config () {
    printf "Installing %s...\n" "$1" >&2
    cat > "$1"
}

patch_config () {
    if [ ! -e "$1".orig ]; then
        cp "$1" "$1".orig
    fi
    cp "$1".orig "$1"
    patch -t "$1"
}

install_script redeploy <<'EOF'
#!/bin/sh
sudo sh /vagrant/deploy.sh
EOF

install_script erlang_experiment <<'EOF'
#!/bin/sh
cd /vagrant
erl erlang_experiment.erl "$@"
EOF

install_packages \
    build-essential \
    erlang \
    erlang-doc
