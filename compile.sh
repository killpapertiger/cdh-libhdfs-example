#!/usr/bin/env bash
source /usr/bin/bigtop-detect-javahome

BASE_PACKAGE_PATH="/usr/lib/hadoop/"
BASE_PARCEL_PATH="/opt/cloudera/parcels/CDH/"

if [[ -d "$BASE_PACKAGE_PATH" ]]
then
  export LD_LIBRARY_PATH="$BASE_PACKAGE_PATH/lib/native/"
elif [[ -d "$BASE_PARCEL_PATH" ]]
then
  export LD_LIBRARY_PATH="$BASE_PARCEL_PATH/lib/hadoop/lib/native/"
  export CFLAGS="-I$BASE_PARCEL_PATH/include/"
fi

export CFLAGS="$CFLAGS -O2 -g -Wall -I$JAVA_HOME/include/ -I$JAVA_HOME/include/linux/"
export LDFLAGS="-lhdfs -L$JAVA_HOME/jre/lib/amd64/server/ -ljvm"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$JAVA_HOME/jre/lib/amd64/server/"

gcc $CFLAGS $LDFLAGS test.c -o test
