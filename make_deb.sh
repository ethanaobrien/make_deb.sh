#!/bin/bash
exec="$0"
name="$1"
file="$2"
version="$3"
description="$4"

if [ -z "$name" ] || [ -z "$file" ] || [ -z "$version" ] || [ -z "$description" ]; then
  echo "usage. $exec <name> <file> <version> <description>"
  exit 1
fi

if [ ! -f "$file" ]; then
  echo "File not found \"$file\""
  exit 1
fi

dirname="$name"_"$version-1"

mkdir $dirname
cd $dirname

mkdir -p "usr/local/bin"
cp ../$file "usr/local/bin/$file"
chmod +x "usr/local/bin/$file"
mkdir DEBIAN

echo "Package: $name" > DEBIAN/control
echo "Version: $version-1" >> DEBIAN/control
echo "Priority: optional" >> DEBIAN/control
echo "Architecture: amd64" >> DEBIAN/control
echo "Maintainer: A guy <email@mail.com>" >> DEBIAN/control
echo "Description: ec $description" >> DEBIAN/control

cd ..
dpkg-deb --build $dirname

rm -R $dirname

echo "built $dirname.deb"
