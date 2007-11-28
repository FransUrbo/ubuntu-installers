#!/bin/sh

if [ -z "$languages" ]; then
	# Please add languages only if they build properly.
	# languages="en cs es fr ja nl pt_BR" # ca da de el eu it ru

 	# Buildlist of languages to be included on Hoary CDs
	languages="en" # cs es fr ja pt_BR
fi

if [ -z "$architectures" ]; then
	architectures="amd64 i386 powerpc"
fi

if [ -z "$destination" ]; then
	destination="/tmp/manual"
fi

[ -e "$destination" ] || mkdir -p "$destination"

if [ "$official_build" ]; then
	# Propigate this to children.
	export official_build
fi

for lang in $languages; do
    echo "Language: $lang";
    for arch in $architectures; do
	echo "Architecture: $arch"
	if [ -n "$noarchdir" ]; then
		destsuffix="$lang"
	else
		destsuffix="${lang}.${arch}"
	fi
	./buildone.sh "$arch" "$lang"
	mkdir "$destination/$destsuffix"
	mv *.html "$destination/$destsuffix"
	./clear.sh
    done
done
