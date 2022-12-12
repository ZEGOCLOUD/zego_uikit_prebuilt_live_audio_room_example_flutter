- - -
# Overview
- - -

**Live Audio Room Kit** is a prebuilt component that helps you to build full-featured live audio rooms into your apps easier.

And it includes the business logic along with the UI, enabling you to customize your live audio apps faster with more flexibility. 


![overview.gif](./../images/final_sublist.gif)


## When do you need the Live Audio Room Kit

- When you want to build live audio rooms easier and faster, it allows you:
    > Build or prototype live audio apps ASAP

    > Finish the integration in the shortest possible time

- When you want to customize UI and features as needed, it allows you:
    > Customize features based on actual business needs

    > Spend less time wasted developing basic features

    > Add or remove features accordingly 


To build a live audio app from scratch, you may check our [Voice Call](https://docs.zegocloud.com/article/13257).

## Embedded features

- Ready-to-use Live Audio Room
- Remove speakers
- Speaker seats changing
- Customizable seat layout
- Extendable menu bar
- Device management
- Customizable UI style
- Real-time interactive text chat


## Recommended resources


* I want to [get started](https://docs.zegocloud.com/article/15079) to implement a live audio room swiftly
* To [configure prebuilt UI](https://docs.zegocloud.com/article/15083) for a custom experience
* I want to get the [Sample Code](https://github.com/ZEGOCLOUD/zego_uikit_prebuilt_live_audio_room_example_flutter)
* To make a fully customized Live Audio app, you may try [this SDK](https://docs.zegocloud.com/article/13257)


- - -
# Quick start
- - -


## Prerequisites

- Go to [ZEGOCLOUD Admin Console](https://console.zegocloud.com), and do the following:
  - Create a project, get the **AppID** and **AppSign**.
  - Activate the **In-app Chat** service (as shown in the following figure).
![ActivateZIMinConsole2.png](https://storage.zego.im/sdk-doc/Pics/InappChat/ActivateZIMinConsole2.png)


## Integrate the SDK

### Add ZegoUIKitPrebuiltLiveAudioRoom as dependencies

Run the following code in your project's root directory: 

```dart
flutter pub add zego_uikit_prebuilt_live_audio_room
```

### Import the SDK

Now in your Dart code, import the Live Audio Room Kit SDK.

```dart
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
```


## Using the Live Audio Room Kit

- Specify the `userID` and `userName` for connecting the Live Audio Room Kit service. 
- `roomID` represents the live audio room you want to create or join.

<div class="mk-hint">

- `userID`, `userName`, and `roomID` can only contain numbers, letters, and underlines (_). 
- Using the same `roomID` will enter the same live audio room.
</div>

<div class="mk-warning">

With the same `roomID`, only one user can enter the live audio room as host. Other users need to enter the live audio room as the audience.
</div>

```dart
class LivePage extends StatelessWidget {
  final String roomID;
  final bool isHost;

  const LivePage({Key? key, required this.roomID, this.isHost = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveAudioRoom(
        appID: yourAppID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: yourAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: 'user_id',
        userName: 'user_name',
        roomID: roomID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
            : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
      ),
    );
  }
}
```

Then, you can create a live audio room. And the audience can join the live audio room by entering the `roomID`.




## Config your project

- Android:

1. If your project is created with Flutter 2.x.x, you will need to open the `your_project/android/app/build.gradle` file, and modify the `compileSdkVersion` to **33**.


   ![compileSdkVersion](https://storage.zego.im/sdk-doc/Pics/ZegoUIKit/Flutter/compile_sdk_version.png)

2. Add app permission.
Open the file `your_project/app/src/main/AndroidManifest.xml`, and add the following:

   ```xml
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.BLUETOOTH" />
   <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   <uses-permission android:name="android.permission.READ_PHONE_STATE" />
   <uses-permission android:name="android.permission.WAKE_LOCK" />
   ```
    <img src="https://storage.zego.im/sdk-doc/Pics/ZegoUIKit/Flutter/live/permission_android.png" width=800>

3. Prevent code obfuscation.

To prevent obfuscation of the SDK public class names, do the following:

a. In your project's `your_project > android > app` folder, create a `proguard-rules.pro` file with the following content as shown below:

<pre style="background-color: #011627; border-radius: 8px; padding: 25px; color: white"><div>
-keep class **.zego.** { *; }
</div></pre>

b. Add the following config code to the `release` part of the `your_project/android/app/build.gradle` file.


<pre style="background-color: #011627; border-radius: 8px; padding: 25px; color: white"><div>
proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
</div></pre>

![android_class_confusion.png](https://storage.zego.im/sdk-doc/Pics/ZegoUIKit/Flutter/android_class_confusion.png)


- iOS:

1. Add app permissions.

a. open the `your_project/ios/Podfile` file, and add the following to the `post_install do |installer|` part:

```plist
# Start of the permission_handler configuration
target.build_configurations.each do |config|
  config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
    '$(inherited)',
    'PERMISSION_CAMERA=1',
    'PERMISSION_MICROPHONE=1',
  ]
end
# End of the permission_handler configuration
```

<img src="https://storage.zego.im/sdk-doc/Pics/ZegoUIKit/Flutter/live/permission_podfile.png" width=800>

b. open the `your_project/ios/Runner/Info.plist` file, and add the following to the `dict` part:

```plist
    <key>NSCameraUsageDescription</key>
    <string>We require camera access to connect to a live</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>We require microphone access to connect to a live</string>
```

<img src="https://storage.zego.im/sdk-doc/Pics/ZegoUIKit/Flutter/live/permission_ios.png" width=800>

2. Disable the Bitcode.

a. Open the `your_project > iOS > Runner.xcworkspace` file.

b. Select your target project, and follow the notes on the following two images to disable the Bitcode respectively.

<img src="https://storage.zego.im/sdk-doc/Pics/ZegoUIKit/Flutter/bitcode_1.png" width=800>
<img src="https://storage.zego.im/sdk-doc/Pics/ZegoUIKit/Flutter/bitcode_2.png" width=800>

##  Run & Test

Now you can simply click the **Run** or **Debug** button to run and test your App on the device.
![run_flutter_project.jpg](https://storage.zego.im/sdk-doc/Pics/ZegoUIKit/Flutter/run_flutter_project.jpg)

## Related guide

[Custom prebuilt UI](https://docs.zegocloud.com/article/15083)
