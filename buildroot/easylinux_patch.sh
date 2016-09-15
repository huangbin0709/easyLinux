#!/bin/sh
archive_dir="$1/../archive/$3"
appinc_dir="$1/../src/application/include"
platinc_dir="$1/../src/platform/include"
build_dir="$2/easylinux"
build_archive_dir="$build_dir/archive"
build_appinc_dir="$build_dir/app"
build_platinc_dir="$build_dir/platform"

if [ ! -d $archive_dir ];
then
    mkdir -p $archive_dir
fi

if [ ! -d $build_dir ];
then
    mkdir -p $build_dir
fi
	
if [ ! -e $build_archive_dir ];
then
    ln -s $archive_dir $build_archive_dir
fi

if [ ! -e $build_appinc_dir ];
then
    ln -s $appinc_dir $build_appinc_dir
fi

if [ ! -e $build_platinc_dir ];
then
    ln -s $platinc_dir $build_platinc_dir
fi