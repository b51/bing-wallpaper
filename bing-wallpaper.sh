#!/usr/bin/env bash

PICTURE_DIR="$HOME/Pictures/bing-wallpaper/wallpapers"

bing_address="http://cn.bing.com"

mkdir -p $PICTURE_DIR

first_urls=( $(curl -s http://cn.bing.com | \
    grep -Eo "url:'.*?'" | \
    sed -e "s/url:'\([^']*\)'.*/\1/" | \
    sed -e "s/\\\//g") )

urls=$bing_address$first_urls

for p in ${urls[@]}; do
    filename=$(echo $p|sed -e "s/.*\/\(.*\)/\1/")
    if [ ! -f $PICTURE_DIR/$filename ]; then
        echo "Downloading: $filename ..."
        echo $urls
        curl -Lo "$PICTURE_DIR/$filename" $p
    else
        echo "Skipping: $filename ..."
    fi
done
