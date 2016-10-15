#!/bin/sh
echo "start system,please wait..."
export PATH=$PATH:/easylinux/app/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/easylinux/lib
/easylinux/app/bin/core
echo "something error,we should not go here"


