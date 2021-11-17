#!/bin/sh

# Simple script to validate the xsd, xsl, and CONstitution.xml according to the xsd.

# Usage
if [ -z "$1" ]
  then
    echo "Usage: check.sh <path-to-tome-xml-file>"
    exit 1
fi

# Check dependencies

missing_deps=false

if ! type xmllint &> /dev/null
  then
    echo "xmllint is not installed"
    missing_deps=true
fi

if ! type xsltproc &> /dev/null
  then
    echo "xsltproc is not installed"
    missing_deps=true
fi

if [ $missing_deps = true ]
  then
    exit 1
fi

# Run in the same directory
cd "$(dirname "$(readlink -f "$0")")"

xmllint --noout --schema tome.xsd $1 || exit 1
xsltproc --noout tome.xsl $1 && echo "$1 transforms" || exit 1
