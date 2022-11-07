import 'dart:io';

import 'package:android_tool/page/common/app.dart';
import 'package:get/get.dart';

class BuildApkLogic extends GetxController {
  String deviceId = "";

  Future<void> face() async {
    await App().execShell('''
        /Users/mt/toast/face/gradlew assembleDebug
        open /Users/mt/toast/face/app/build/outputs/apk/debug
        open -a filezilla
        ''');
  }

  Future<void> weight() async {
    await App().execShell('''
        /Users/mt/toast/toastcashierm/gradlew assembleDebug
        open /Users/mt/toast/toastcashierm/app/build/outputs/apk/debug
        open -a filezilla
        ''');
  }

  ai() async {
    await App().execShell('''
     /Users/mt/toast/toastcashier/gradlew assembleDebug
     open /Users/mt/toast/toastcashier/app/build/outputs/apk/debug
     open -a filezilla
    ''');
  }
}
