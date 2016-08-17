#!/bin/bash

set -e

tag_exists () {
	return $(git rev-parse -q --verify "refs/tags/$1" > /dev/null)
}

if [ "${TRAVIS}" != "true" ]; then
	echo "This script should only be executed from Travis CI"
	return 1
fi

DESC=`git log -1 --pretty=%B`
DATE=`date +%Y%m%d`
TAG=$DATE
i=1

while tag_exists $TAG; do
	i=$((i + 1))
	TAG="$DATE.$(echo {A..Z} | sed 's/ //g' | head -c $i | tail -c 1)"
done

echo "Creating tag $TAG with message '$DESC'"
git tag -a $TAG -m "$DESC"

echo "Pushing tag"
git push --quiet https://$GIT_LOGIN:$GIT_TOKEN@$GIT_REPO $TAG > /dev/null 2>&1
