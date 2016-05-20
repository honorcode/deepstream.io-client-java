# Paths and Stuff
DIRECTORY=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
if [ -z ${TRAVIS_BUILD_DIR} ]; then
	export TRAVIS_BUILD_DIR=$DIRECTORY;
fi
J2OBJC_ROOT=$TRAVIS_BUILD_DIR/j2objcDist

# Create local.properties for gradlew
#sed -i '' '/j2objc.home/d' $DIRECTORY/local.properties
echo j2objc.home=$J2OBJC_ROOT/j2objc-0.9.8.2.1 >> $DIRECTORY/local.properties
if [[ "$TRAVIS_OS_NAME" == "osx" && "$OSTYPE" == "darwin"* ]]; then
	echo 'Wooho! Mac! j2objc compilation!';
else
	echo 'Only transpiling will occur';
	echo j2objc.translateOnlyMode=true >> $DIRECTORY/local.properties;
fi

# Download J2OBJC
mkdir -p $J2OBJC_ROOT;
pushd $J2OBJC_ROOT;
if [ ! -d "$J2OBJC_ROOT/j2objc-0.9.8.2.1" ]; then
	curl -L https://github.com/google/j2objc/releases/download/0.9.8.2.1/j2objc-0.9.8.2.1.zip > j2objc-0.9.8.2.1.zip
	unzip j2objc-0.9.8.2.1.zip; popd
else
	echo 'j2objc already downloaded';
fi