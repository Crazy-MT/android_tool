import 'dart:math';

import 'package:android_tool/page/haimakeyboard/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/text_view.dart';
import '../common/app.dart';
import '../common/icon_font.dart';

class MaiMaPage extends StatefulWidget {
  final logic = Get.put(HaiMaLogic());
  var _dragData = [];
  var up;

  MaiMaPage({Key? key, required String deviceId}) : super(key: key) {
    logic.deviceId = deviceId;
  }

  @override
  State<MaiMaPage> createState() => _MaiMaPageState();
}

class _MaiMaPageState extends State<MaiMaPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.up = {
      "name": "up",
      // "up": {widget.logic.pressSwipeUp(context)}
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _featureCardView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(child: titleView("键盘")),
                          // _packageNameView(context),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buttonView(IconFont.uninstall, "功能", () async {
                            await widget.logic.pressKey(context, '131');
                          }, const {"name": "func"}),
                          buttonView(IconFont.start, "↑", () async {
                            await widget.logic.pressKey(context, '19');
                          }, const {"name": "moveUp"}),
                          buttonView(IconFont.stop, "↓", () async {
                            await widget.logic.pressKey(context, '20');
                          }, const {"name": "moveDown"}),
                          buttonView(IconFont.rerun, "设置", () async {
                            await widget.logic.pressKey(context, '132');
                          }, const {"name": "setting"}),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buttonView(IconFont.uninstall, "7", () async {
                            await widget.logic.pressKey(context, '151');
                          }, const {"name": "7"}),
                          buttonView(IconFont.cleanRerun, "8", () async {
                            await widget.logic.pressKey(context, '152');
                          }, const {"name": "8"}),
                          buttonView(IconFont.reset, "9", () async {
                            await widget.logic.pressKey(context, '153');
                          }, const {"name": "9"}),
                          buttonView(IconFont.resetRerun, "取消", () async {
                            await widget.logic.pressKey(context, '4');
                          }, const {"name": "cancel"}),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buttonView(IconFont.authorize, "4", () async {
                            await widget.logic.pressKey(context, '148');
                          }, const {"name": "4"}),
                          buttonView(IconFont.apkPath, "5", () async {
                            await widget.logic.pressKey(context, '149');
                          }, const {"name": "5"}),
                          buttonView(IconFont.save, "6", () async {
                            await widget.logic.pressKey(context, '150');
                          }, const {"name": "6"}),
                          buttonView(IconFont.save, "删除", () async {
                            await widget.logic.pressKey(context, '67');
                          }, const {"name": "dele"})
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buttonView(IconFont.authorize, "1", () async {
                            await widget.logic.pressKey(context, '145');
                          }, const {"name": "1"}),
                          buttonView(IconFont.apkPath, "2", () async {
                            await widget.logic.pressKey(context, '146');
                          }, const {"name": "2"}),
                          buttonView(IconFont.save, "3", () async {
                            await widget.logic.pressKey(context, '147');
                          }, const {"name": "3"}),
                          buttonView(IconFont.save, "确认", () async {
                            await widget.logic.pressKey(context, '66');
                          }, const {"name": "confirm"}),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buttonView(IconFont.authorize, "0", () async {
                            await widget.logic.pressKey(context, '144');
                          }, const {"name": "0"}),
                          buttonView(IconFont.apkPath, ".", () async {
                            await widget.logic.pressKey(context, '158');
                          }, const {"name": "."}),
                          buttonView(IconFont.save, "+", () async {
                            await widget.logic.pressKey(context, '157');
                          }, const {"name": "+"}),
                          buttonView(IconFont.save, "二代确认", () async {
                            await widget.logic.pressKey(context, '160');
                          }, const {"name": "confirm"})
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    // _buildDraggable(),
                    // SizedBox(height: 200),
                    DragTarget<Map>(
                      builder: (context, List<Map?> candidateData,
                          List<dynamic> rejectedData) {
                        return Container(
                          height: 300,
                          width: 10000,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Text("执行集合"),
                                onTap: () async {
                                  for (var element in widget._dragData) {
                                    await process(element, context);
                                  }
                                },
                              ),
                              Wrap(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widget._dragData
                                      .asMap()
                                      .entries
                                      .map((entry) => entry.value["name"] ==
                                              "click"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                TextView(entry.key.toString() +
                                                    " " +
                                                    entry.value["name"]),
                                                Container(
                                                  width: 100,
                                                  child: TextField(
                                                    autofocus: true,
                                                    // controller: _controller,
                                                    decoration: InputDecoration(
                                                        hintText: "x,y"),
                                                    onSubmitted:
                                                        (String value) {
                                                      entry.value["point"] =
                                                          value;
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          : InkWell(
                                              child: textView(
                                                  entry.value["name"]),
                                              onTap: () async {
                                                await process(
                                                    entry.value, context);
                                              },
                                            ))
                                      .toList()),
                            ],
                          ),
                        );
                      },
                      onWillAccept: (Map? color) {
                        print('onWillAccept:$color');
                        return true;
                      },
                      onAccept: (Map data) {
                        setState(() {
                          widget._dragData.add(data);
                        });
                        // print('onAccept:$data');
                      },
                      onLeave: (Map? color) {
                        // print('onLeave:$color');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ))
      ],
    );
  }

  Future<void> process(element, BuildContext context) async {
    var name = element["name"];
    if (name == "func") {
      await widget.logic.pressKey(context, '131');
    }
    if (name == "moveUp") {
      await widget.logic.pressKey(context, '19');
    }
    if (name == "moveDown") {
      await widget.logic.pressKey(context, '20');
    }
    if (name == "setting") {
      await widget.logic.pressKey(context, '132');
    }
    if (name == "7") {
      await widget.logic.pressKey(context, '151');
    }
    if (name == "8") {
      await widget.logic.pressKey(context, '152');
    }
    if (name == "9") {
      await widget.logic.pressKey(context, '153');
    }
    if (name == "cancel") {
      await widget.logic.pressKey(context, '4');
    }
    if (name == "4") {
      await widget.logic.pressKey(context, '148');
    }
    if (name == "5") {
      await widget.logic.pressKey(context, '149');
    }
    if (name == "6") {
      await widget.logic.pressKey(context, '150');
    }
    if (name == "dele") {
      await widget.logic.pressKey(context, '67');
    }
    if (name == "1") {
      await widget.logic.pressKey(context, '145');
    }
    if (name == "2") {
      await widget.logic.pressKey(context, '146');
    }
    if (name == "3") {
      await widget.logic.pressKey(context, '147');
    }
    if (name == "confirm") {
      await widget.logic.pressKey(context, '66');
    }
    if (name == "0") {
      await widget.logic.pressKey(context, '144');
    }
    if (name == ".") {
      await widget.logic.pressKey(context, '158');
    }
    if (name == "+") {
      await widget.logic.pressKey(context, '157');
    }
  }

  Widget titleView(String title) {
    return Row(
      children: [
        Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            )),
        const SizedBox(width: 5),
        TextView(title),
      ],
    );
  }

  Container _featureCardView({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Ink(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: child,
      ),
    );
  }

  Widget buttonView(IconData icon, String title, Function() onPressed, data) {
    Color color = Colors.red;
    return InkWell(
      onTap: onPressed,
      child: Draggable(
        data: data,
        feedback: textView(title),
        child: textView(title),
      ),
    );
    // return Expanded(
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: MaterialButton(
    //       height: 45,
    //       color: Colors.blue,
    //       onPressed: onPressed,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10.0),
    //       ),
    //       child: ,
    //     ),
    //   ),
    // );
  }

  Container textView(String title) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      // padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextView(
        title,
        fontSize: 14,
      ),
    );
  }

  _buildDraggable() {
    return Draggable(
      data: Color(0x000000FF),
      child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: Text(
          '孟',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      feedback: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: Colors.white, fontSize: 18),
          child: Text(
            '孟',
          ),
        ),
      ),
    );
  }
}
