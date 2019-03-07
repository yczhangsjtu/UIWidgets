#! /bin/sh

PROJECT_PATH=$(pwd)/artifact/$UNITY_PROJECT_PATH
UNITY_BUILD_DIR=$(pwd)/artifact/Build
LOG_FILE=$UNITY_BUILD_DIR/unity.log

ERROR_CODE=0

echo "Running Editor Tests..."
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
  -batchmode \
  -nographics \
  -silent-crashes \
  -logFile \
  -projectPath "$PROJECT_PATH"\
  -runEditorTests \
  | tee "$LOG_FILE"

if [ "$?" == "0" ] ; then
  echo "Tests completed successfully."
  ERROR_CODE=0
else
  echo "Tests failed. Exited with $?."
  ERROR_CODE=1
fi

echo "Finishing with code $ERROR_CODE"
exit $ERROR_CODE
