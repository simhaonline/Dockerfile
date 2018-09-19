#!/bin/sh

set -e
set -x

[ "$(id -u)" -eq 0 ] || {
	printf >&2 '%s requires root\n' "$0"
	exit 1
}

tmp() {
	TMP=$(mktemp -d ${TMPDIR:-/var/tmp}/alpine-docker-XXXXXXXXXX)
	ROOTFS=$(mktemp -d ${TMPDIR:-/var/tmp}/alpine-docker-rootfs-XXXXXXXXXX)
	trap 'rm -rf $TMP $ROOTFS' EXIT TERM INT
}

apkv() {
	curl -sSL $MAINREPO/$ARCH/APKINDEX.tar.gz | tar -Oxz |
		grep --text '^P:apk-tools-static$' -A1 | tail -n1 | cut -d: -f2
}

getapk() {
	curl -sSL "$MAINREPO/$ARCH/apk-tools-static-$(apkv).apk" |
		tar -xz -C $TMP sbin/apk.static
}

mkbase() {
	$TMP/sbin/apk.static --repository $MAINREPO --update-cache --allow-untrusted \
		--root $ROOTFS --initdb add alpine-base

    rm -f "$ROOTFS/var/cache/apk/*"
}

conf() {
	printf '%s\n' $MAINREPO > $ROOTFS/etc/apk/repositories
	printf '%s\n' $ADDITIONALREPO >> $ROOTFS/etc/apk/repositories
}

save() {
	tar --numeric-owner -C $ROOTFS -c . | xz > rootfs.tar.xz
}

REL=${REL:-v3.8}
MIRROR=${MIRROR:-http://nl.alpinelinux.org/alpine}
MAINREPO=$MIRROR/$REL/main
ADDITIONALREPO=$MIRROR/$REL/community
ARCH=$(uname -m)

if [ "$ARCH" = "armv6l" ]; then
    ARCH=armhf
elif [ "$ARCH" = "armv7l" ]; then
    ARCH=armhf
elif [ "$ARCH" = "aarch64" ]; then
    ARCH=aarch64
elif [ "$ARCH" = "x86_64" ]; then
    ARCH=x86_64
elif [ "$ARCH" = "x86" ]; then
    ARCH=x86
else
    ARCH=$(uname -m)
fi

tmp
getapk
mkbase
conf
save

