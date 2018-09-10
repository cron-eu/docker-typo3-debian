#!/usr/bin/env /bin/bash

##
# Install the TYPO3 source in /var/www/html
#

set -ex

TYPO3_DISTRIBUTION="$1" ; shift
INSTALL_PATH="$1" ; shift

cd "${INSTALL_PATH}" || exit 1
rm *

composer create-project ${TYPO3_DISTRIBUTION} .
touch web/FIRST_INSTALL
