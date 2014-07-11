@echo off

rem Just some shortcut functions to test things on Android.

echo Android Test Util by Steve Richey.

rem "test android fast" will just load the current exported APK on the connected device.
if %1_%2==android_fast (
	echo Not building, just sending to device...
	adb shell am force-stop com.dreamshowadventures.drillbunny
	adb shell am start -a android.intent.action.DELETE -d package:com.dreamshowadventures.drillbunny
	adb shell input tap 464 786
	adb install export/android/bin/bin/DrillBunny-debug.apk
	adb shell am start -n com.dreamshowadventures.drillbunny/com.dreamshowadventures.drillbunny.MainActivity
)

rem "test android clean" does a clean build and loads the APK on the device wirelessly.
if %1_%2==android_clean (
	echo Doing clean build, and sending to device wirelessly...
	echo y | rd export /s
	lime build android
	adb tcpip
	adb connect 192.168.1.115:5555
	adb shell am force-stop com.dreamshowadventures.drillbunny
	adb shell am start -a android.intent.action.DELETE -d package:com.dreamshowadventures.drillbunny
	adb shell input tap 464 786
	adb install export/android/bin/bin/DrillBunny-debug.apk
	adb shell am start -n com.dreamshowadventures.drillbunny/com.dreamshowadventures.drillbunny.MainActivity
)

rem "test android" does a standard build and loads the APK on the device.
if %1_%2==android_ (
	echo Doing regular build, sending to device...
	lime build android
	adb shell am force-stop com.dreamshowadventures.drillbunny
	adb shell am start -a android.intent.action.DELETE -d package:com.dreamshowadventures.drillbunny
	adb shell input tap 464 786
	adb install export/android/bin/bin/DrillBunny-debug.apk
	adb shell am start -n com.dreamshowadventures.drillbunny/com.dreamshowadventures.drillbunny.MainActivity
)

if %1_%2==_ (
	echo No target specified! Try "test android", "test android clean", or "test android fast"!
)