
#!/bin/sh
archive_dir=$1/../archive/$3
appinc_dir=$1/../src/application/include
platinc_dir=$1/../src/platform/include
build_dir=$2/easylinux
build_archive_dir=$build_dir/archive
build_appinc_dir=$build_dir/app
build_platinc_dir=$build_dir/platform

if [ -d $archive_dir ];
then
    rm -rf $archive_dir
fi

if [ -d $build_dir ];
then
	rm -rf $build_dir
fi