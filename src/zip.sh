#!/bin/sh

version=0-1-0

cd ../build
rm *.zip
zip -q -r ../build.zip *
mv ../build.zip ../build/recipe-tweaks-${version}.zip
