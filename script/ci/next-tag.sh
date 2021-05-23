#!/bin/bash

set -e

tag_exists () {
	return $(git rev-parse -q --verify "refs/tags/$1" > /dev/null)
}

DATE=`date +%Y%m%d`
TAG=$DATE
i=1

while tag_exists $TAG; do
	i=$((i + 1))
	TAG="$DATE-$(echo {A..Z} | sed 's/ //g' | head -c $i | tail -c 1)"
done

echo "$TAG"
