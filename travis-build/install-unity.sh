#! /bin/sh

# See https://unity3d.com/get-unity/download/archive
# to get download URLs
UNITY_DOWNLOAD_CACHE="$(pwd)/unity_download_cache"
UNITY_OSX_PACKAGE_URL="http://download.unity3d.com/download_unity/6e9a27477296/MacEditorInstaller/Unity.pkg"

# Downloads a file if it does not exist
download() {

	URL=$1
	FILE=`basename "$URL"`
	
	# Downloads a package if it does not already exist in cache
	if [ ! -e $UNITY_DOWNLOAD_CACHE/`basename "$URL"` ] ; then
		echo "$FILE does not exist. Downloading from $URL: "
		mkdir -p "$UNITY_DOWNLOAD_CACHE"
		curl -o $UNITY_DOWNLOAD_CACHE/`basename "$URL"` "$URL"
	else
		echo "$FILE Exists. Skipping download."
	fi
}

# Downloads and installs a package from an internet URL
install() {
	PACKAGE_URL=$1
	download $1

	echo "Installing `basename "$PACKAGE_URL"`"
	sudo installer -dumplog -package $UNITY_DOWNLOAD_CACHE/`basename "$PACKAGE_URL"` -target /
}



echo "Contents of Unity Download Cache:"
ls $UNITY_DOWNLOAD_CACHE

echo "Installing Unity..."
install $UNITY_OSX_PACKAGE_URL

echo "Activating license"
mkdir -p ~/Library/Unity/Certificates
cp $(pwd)/CACerts.pem ~/Library/Unity/Certificates/
cp $(pwd)/Unity_lic.ulf "/Library/Application Support/Unity/"
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
  -batchmode \
  -username "$UNITY_USERNAME" \
  -password "$UNITY_PASSWORD" \
  -logFile \
  -noUpm \
  -quit

