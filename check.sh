#!/bin/sh

# Simple script to validate the xsd, xsl, and CONstitution.xml according to the xsd.

# Run in the same directory
cd "$(dirname "$(readlink -f "$0")")"

xmllint --noout --schema tome.xsd CONstitution.xml || exit 1
xsltproc --noout tome.xsl CONstitution.xml && echo "xsltproc completed successfully" || exit 1
