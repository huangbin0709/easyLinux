#!/bin/sh
archive_dir=$1/../archive/$4
target_dir=$3/easylinux
appinc_dir=$1/../src/application/include
platinc_dir=$1/../src/platform/include
build_dir=$2/easylinux
build_archive_dir=$build_dir/archive
build_appinc_dir=$build_dir/app
build_platinc_dir=$build_dir/platform

if [ ! -d $archive_dir ];
then
    mkdir -p $archive_dir
fi

if [ ! -d $build_dir ];
then
    mkdir -p $build_dir
fi
	
if [ ! -d $target_dir ];
then
    mkdir -p $target_dir
fi

if [ ! -d $target_dir/lib/modules ];
then
    mkdir -p $target_dir/lib/modules
fi

if [ ! -L $build_archive_dir ];
then
    ln -s $archive_dir $build_archive_dir
fi

if [ ! -L $build_appinc_dir ];
then
    ln -s $appinc_dir $build_appinc_dir
fi

if [ ! -L $build_platinc_dir ];
then
    ln -s $platinc_dir $build_platinc_dir
fi
