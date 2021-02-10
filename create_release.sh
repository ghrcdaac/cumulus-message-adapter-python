#!/bin/bash
set -ex
export VERSION=$1
export RELEASE_NAME=cma_python

## Create Release
   export RELEASE_URL=$(curl -H\
  "Authorization: token $SECRET_TOKEN"\
   -d "{\"tag_name\": \"$VERSION\", \"target_commitsh\": \"$VERSION\", \"name\": \"$VERSION\", \"body\": \"Release $VERSION\" }"\
   -H "Content-Type: application/json"\
   -X POST\
   https://api.github.com/repos/$GITHUB_REPO/releases |grep \"url\" |grep releases |sed -e 's/.*\(https.*\)\"\,/\1/'| sed -e 's/api/uploads/')

python createPackage.py

### Post the release
curl -X POST -H "Authorization: token $SECRET_TOKEN" --data-binary "@${RELEASE_NAME}.zip" -H "Content-type: application/octet-stream" $RELEASE_URL/assets?name=${RELEASE_NAME}.zip
