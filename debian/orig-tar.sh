#!/bin/sh 

set -e

# called by uscan with '--upstream-version' <version> <file>
echo "version $2"
package=`dpkg-parsechangelog | sed -n 's/^Source: //p'`
version=$2
tarball=$3
TAR=${package}_${version}.orig.tar.gz
DIR=${package}-${version}.orig
upstream_package="$(echo $package | sed 's/-java//')"
REPO="http://svn.apache.org/repos/asf/tuscany/sdo-java/tags/${version}/${upstream_package}/"

TZ=UTC LC_ALL=C svn export $REPO $DIR
GZIP=--best tar --numeric --group 0 --owner 0 -c -v -z -f $TAR $DIR

rm -rf $tarball $DIR
