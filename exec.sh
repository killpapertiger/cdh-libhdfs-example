source /usr/bin/bigtop-detect-javahome
export CLASSPATH=/etc/hadoop/conf

BASE_PACKAGE_PATH="/usr/lib/hadoop/"
BASE_PARCEL_PATH="/opt/cloudera/parcels/CDH/"

CLIENT_DIR="${BASE_PACKAGE_PATH}"
if [[ -d "${BASE_PARCEL_PATH}" ]]
then
  CLIENT_DIR="${BASE_PARCEL_PATH}/lib/hadoop/client"
else
  CLIENT_DIR="${BASE_PACKAGE_PATH}/client"
fi

# We need an explicit classpath as JNI does not support wildcard classpaths
for jar_file in $(ls $CLIENT_DIR/*.jar)
do
  export CLASSPATH=$CLASSPATH:$jar_file
done

export LD_LIBRARY_PATH="$JAVA_HOME/jre/lib/amd64/server/"

if [[ -d "${BASE_PARCEL_PATH}" ]]
then
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$BASE_PARCEL_PATH/lib/hadoop/lib/native/"
fi

./test
