#!/bin/bash

SRCDIR="$1"

set -eux

if [ $# -ne 1 ]
then
  echo "Usage: $0 <debianized_source_dir>"
  exit 1
fi

if [ ! -d "${SRCDIR}" ]
then
  echo "Sourcedir ${SRCDIR} not found?! Aborting build..."
  exit 1
fi

pushd ${SRCDIR}

echo ">>> INSTALLING BUILD DEPENDENCIES <<<"
sudo apt-get install -y $(dpkg-checkbuilddeps 2>&1 | sed -e 's/.*dependencies://' -e 's/ ([^)]*)/ /g')

echo ">>> BUILDING DEBIAN PACKAGES <<<"
gbp buildpackage --git-ignore-branch -us -uc

## .deb && *.ddeb packages should be available now
