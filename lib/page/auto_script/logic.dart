import 'dart:io';

import 'package:android_tool/page/common/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/input_dialog.dart';
import '../../widget/result_dialog.dart';

class AutoLogic extends GetxController {
  String deviceId = "";


  AutoLogic() {

  }

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

  Future<void> process(List<String> list) async {
    await App().execShell('''
      ${list.join('\n')}
    ''');
  }

  ai() async {
    await App().execShell('''
     /Users/mt/toast/toastcashier/gradlew assembleDebug
     open /Users/mt/toast/toastcashier/app/build/outputs/apk/debug
     open -a filezilla
    ''');
  }

  /// 屏幕点击
  Future<void> pressScreen(BuildContext context, input) async {
    // var input = await showInputDialog(context, title: "请输入坐标", hintText: "x,y");
    if (input == null || input.isEmpty) {
      return;
    }
    if (!input.contains(",")) {
      showResultDialog(context, content: "请输入正确的坐标");
      return;
    }
    await execAdb(context, [
      '-s',
      deviceId,
      'shell',
      'input',
      'tap',
      input.replaceAll(",", " "),
    ]);
  }

  /// 向上滑动
  Future<void> pressSwipeUp(BuildContext context) async {
    // return (await App().getAdbPath()) + " -s " + deviceId + " shell input swipe 300 1300 300 300";
    await execAdb(context, [
      '-s',
      deviceId,
      'shell',
      'input',
      'swipe',
      '300',
      '1300',
      '300',
      '300',
    ]);
  }

  /// 向下滑动
  Future<void> pressSwipeDown(BuildContext context) async {
    // return (await App().getAdbPath()) + " -s " + deviceId + " shell input swipe 300 300 300 1300";
    await execAdb(context, [
      '-s',
      deviceId,
      'shell',
      'input',
      'swipe',
      '300',
      '300',
      '300',
      '1300',
    ]);
  }

  /// 向左滑动
  Future<void> pressSwipeLeft(BuildContext context) async {
    // return (await App().getAdbPath()) + " -s " + deviceId + " shell input swipe 900 300 100 300";
    await execAdb(context, [
      '-s',
      deviceId,
      'shell',
      'input',
      'swipe',
      '900',
      '300',
      '100',
      '300',
    ]);
  }

  /// 向右滑动
  Future<void> pressSwipeRight(BuildContext context) async {
    // return (await App().getAdbPath()) + " -s " + deviceId + " shell input swipe 100 300 900 300";
    await execAdb(context, [
      '-s',
      deviceId,
      'shell',
      'input',
      'swipe',
      '100',
      '300',
      '900',
      '300',
    ]);
  }

  Future<String?> showInputDialog(BuildContext context, {
    String title = "输入文本",
    String hintText = "输入文本",
  }) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return InputDialog(
          title: title,
          hintText: hintText,
        );
      },
    );
  }

  void showResultDialog(BuildContext context, {String? title, String? content, bool? isSuccess}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: title,
          content: content,
          isSuccess: isSuccess,
        );
      },
    );
  }

  Future<ProcessResult?> execAdb(BuildContext context,List<String> arguments,
      {void Function(Process process)? onProcess}) async {
    // print('MTMTMT BaseViewModel.execAdb ${adbPath} ');
    if ((await App().getAdbPath()).isEmpty) {
      showResultDialog(
        context,
        title: "ADB没有找到",
        content: "请配置ADB环境变量",
      );
      return null;
    }
    return await exec((await App().getAdbPath()), arguments, onProcess: onProcess);
  }

  Future<ProcessResult?> exec(
      String executable,
      List<String> arguments, {
        String loadingText = "执行中...",
        void Function(Process process)? onProcess,
      }) async {
    // setLoading(true, text: loadingText);
    try {
      // print('MTMTMT BaseViewModel.exec ${shell.kill()} ');
      return await App().shell.runExecutableArguments(executable, arguments,
          onProcess: onProcess);
    } catch (e) {
      print(e);
      return null;
    } finally {
      // setLoading(false, text: "");
    }
  }

}
