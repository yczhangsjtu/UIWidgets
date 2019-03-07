#! /bin/sh

PROJECT_PATH=$(pwd)/artifact/$UNITY_PROJECT_PATH
UNITY_BUILD_DIR=$(pwd)/artifact/Build
LOG_FILE=$UNITY_BUILD_DIR/unity.log

ERROR_CODE=0

echo "Creating empty project..."
mkdir -p $PROJECT_PATH
mkdir -p $UNITY_BUILD_DIR
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
  -batchmode \
  -nographics \
  -silent-crashes \
  -logFile \
  -createProject "$PROJECT_PATH" \
  -quit \
  | tee "$LOG_FILE"

if [ "$?" == "0" ] ; then
  echo "Creating empty project completed successfully."
  ERROR_CODE=0
else
  echo "Creating emtpy project failed. Exited with $?."
  ERROR_CODE=1
  echo "Finishing with code $ERROR_CODE"
  exit $ERROR_CODE
fi

mkdir -p $PROJECT_PATH/Assets/$PACKAGE_NAME
cp -r $(pwd)/Editor $(pwd)/Runtime $(pwd)/Tests $(pwd)/scripts $PROJECT_PATH/Assets/$PACKAGE_NAME

echo "Copy package folder to empty project"
if [ "$?" == "0" ] ; then
  echo "Copy completed successfully."
  ERROR_CODE=0
else
  echo "Copy failed. Exited with $?."
  ERROR_CODE=1
fi

echo "Finishing with code $ERROR_CODE"
exit $ERROR_CODE
