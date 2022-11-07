import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class BuildApkPage extends StatelessWidget {
  final logic = Get.put(BuildApkLogic());

  BuildApkPage({Key? key, required String deviceId}) : super(key: key) {
    logic.deviceId = deviceId;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(onPressed: () => logic.face(), child: Text("人脸识别")),
        TextButton(onPressed: () { logic.weight();}, child: Text("称重")),
        TextButton(onPressed: () => logic.ai(), child: Text("AI")),
      ],
    );
  }
}
