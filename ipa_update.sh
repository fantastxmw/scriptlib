#!/bin/sh

echo "removed Compiled folder"
rm -Rf Compiled

echo "build lua script"
cd lua
./build.sh
cd ..

echo "update script and UI, etc"
cd Distribution
./collect_updates.sh

echo "update svn and export package"
cd ArpgGameUpdate
./svn_update_export.sh

echo "copy packages to xcode"
cp -R package/* ~/Project/ArpgGame/ArpgGame/Resources/Documents/

echo "backup Documents links"
mv ~/Project/JXQYM-APP/JXQYM.app/Documents ~/Project/JXQYM-APP/JXQYM.app/Documents.bk

echo "archive project"
cd ~/Project/ArpgGame/
xcodebuild -scheme JXQYM archive -archivePath /Volumes/mobile-dev/JXQYM

if [ $? -ne 0 ]; then
	exit 1
fi

echo "remove JXQYM.ipa file"
rm /Volumes/mobile-dev/Distribution/ArpgGameUpdate/versions/JXQYM.ipa

echo "export ipa and resign as adhoc"
cd /Volumes/mobile-dev/
xcodebuild -exportArchive -exportFormat IPA -archivePath JXQYM.xcarchive -exportPath /Volumes/mobile-dev/Distribution/ArpgGameUpdate/versions/JXQYM.ipa -exportProvisioningProfile 'adhocdistribution'

if [ $? -ne 0 ]; then
	exit 1
fi

echo "clean archive file"
rm -rf JXQYM.xcarchive

echo "upload new ipa version"
cd /Volumes/mobile-dev/Distribution/ArpgGameUpdate/versions
svn ci -m "update"

echo "restore the Resources of project"
cd /Volumes/mobile-dev/
./back_to_dev.sh

