import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/text_view.dart';
import '../common/app.dart';
import '../common/icon_font.dart';
import 'logic.dart';

class AutoPage extends StatefulWidget {
  final logic = Get.put(AutoLogic());
  var _dragData = [];
  var up;

  AutoPage({Key? key, required String deviceId}) : super(key: key) {
    logic.deviceId = deviceId;
  }

  @override
  State<AutoPage> createState() => _AutoPageState();
}

class _AutoPageState extends State<AutoPage> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _featureCardView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleView("屏幕输入"),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Draggable(
                            data: const {"name": "up"},
                            feedback: buttonView(
                              IconFont.swipeUp,
                              "向上滑动",
                              () {
                                widget.logic.pressSwipeUp(context);
                              },
                            ),
                            child: buttonView(
                              IconFont.swipeUp,
                              "向上滑动",
                              () {
                                widget.logic.pressSwipeUp(context);
                              },
                            ),
                          ),
                          Draggable(
                            data: const {"name": "down"},
                            child: buttonView(
                              IconFont.swipeDown,
                              "向下滑动",
                              () {
                                widget.logic.pressSwipeDown(context);
                              },
                            ),
                            feedback: buttonView(
                              IconFont.swipeDown,
                              "向下滑动",
                              () {
                                widget.logic.pressSwipeDown(context);
                              },
                            ),
                          ),
                          Draggable(
                            data: const {"name": "left"},
                            child: buttonView(
                              IconFont.swipeLeft,
                              "向左滑动",
                              () {
                                widget.logic.pressSwipeLeft(context);
                              },
                            ),
                            feedback: buttonView(
                              IconFont.swipeLeft,
                              "向左滑动",
                              () {
                                widget.logic.pressSwipeLeft(context);
                              },
                            ),
                          ),
                          Draggable(
                            data: const {"name": "right"},
                            feedback: buttonView(
                              IconFont.swipeRight,
                              "向右滑动",
                              () {
                                widget.logic.pressSwipeRight(context);
                              },
                            ),
                            child: buttonView(
                              IconFont.swipeRight,
                              "向右滑动",
                              () {
                                widget.logic.pressSwipeRight(context);
                              },
                            ),
                          ),
                          Draggable(
                            data: {"name": "click"},
                            feedback: buttonView(
                              IconFont.click,
                              "屏幕点击",
                                  () {
                                // widget.logic.pressScreen(context);
                              },
                            ),
                            child: buttonView(
                              IconFont.click,
                              "屏幕点击",
                                  () {
                                // widget.logic.pressScreen(context);
                              },
                            ),
                          )
                        ],
                      ),
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
                          height: 400,
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
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              child: TextView(
                                                  entry.key.toString() +
                                                      " " +
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
    if (name == "up") {
      await widget.logic.pressSwipeUp(context);
    }
    if (name == "down") {
      (await widget.logic.pressSwipeDown(context));
    }
    if (name == "left") {
      await widget.logic.pressSwipeLeft(context);
    }
    if (name == "right") {
      await widget.logic.pressSwipeRight(context);
    }
    if (name == "click") {
      await widget.logic.pressScreen(context, element["point"]);
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

  Widget buttonView(IconData icon, String title, Function() onPressed) {
    Color color = Colors.red;
    return Container(
      // width: 100,
      // height: 100,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Container(
          //   width: 40,
          //   height: 40,
          //   padding: const EdgeInsets.all(5),
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       gradient: LinearGradient(
          //         colors: [
          //           color.withOpacity(0.5),
          //           color.withOpacity(1),
          //         ],
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //       )),
          //   child: Icon(
          //     icon,
          //     color: Colors.white,
          //   ),
          // ),
          const SizedBox(height: 5),
          TextView(
            title,
            fontSize: 14,
          )
        ],
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
