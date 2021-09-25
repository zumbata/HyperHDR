#!/bin/bash -e

# Download latest release
echo 'Downloading HyperHDR.........................'
cd /tmp

HYPERHDR_VERSION=$(curl -k --silent "https://api.github.com/repos/awawa-dev/HyperHDR/releases/latest" | grep -oP '"tag_name": "v\K([0-9\.]*)(?=")')
echo Selecting version: ${HYPERHDR_VERSION}

if [ "$DEPLOY_DIR" != "${DEPLOY_DIR/v7/}" ]; then
    echo 'BUILDING ARM v7 RELEASE............................'
    wget https://github.com/awawa-dev/HyperHDR/releases/download/v${HYPERHDR_VERSION}/HyperHDR-${HYPERHDR_VERSION}-Linux-armv7l.deb
    apt install ./HyperHDR-${HYPERHDR_VERSION}-Linux-armv7l.deb
    rm HyperHDR-${HYPERHDR_VERSION}-Linux-armv7l.deb
elif [ "$DEPLOY_DIR" != "${DEPLOY_DIR/v8/}" ]; then
    echo 'BUILDING ARM aarch64 RELEASE............................'
    wget https://github.com/awawa-dev/HyperHDR/releases/download/v${HYPERHDR_VERSION}/HyperHDR-${HYPERHDR_VERSION}-Linux-aarch64.deb
    apt install ./HyperHDR-${HYPERHDR_VERSION}-Linux-aarch64.deb
    rm HyperHDR-${HYPERHDR_VERSION}-Linux-aarch64.deb
else
    echo 'BUILDING ARM v6 RELEASE............................'
    wget https://github.com/awawa-dev/HyperHDR/releases/download/v${HYPERHDR_VERSION}/HyperHDR-${HYPERHDR_VERSION}-Linux-armv6l.deb
    apt install ./HyperHDR-${HYPERHDR_VERSION}-Linux-armv6l.deb
    rm HyperHDR-${HYPERHDR_VERSION}-Linux-armv6l.deb
fi

echo 'Registering HyperHdr service........................'
systemctl -q enable hyperhdr@pi.service

sed -i "s/^#dtparam=spi=on.*/dtparam=spi=on/" /boot/config.txt
sed -i "s/^#hdmi_force_hotplug=1.*/hdmi_force_hotplug=1/" /boot/config.txt

