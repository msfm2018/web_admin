import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myplus/myplus.dart';

class P3 extends StatefulWidget {
  P3(this.name, {Key? key}) : super(key: key);
  String name = '';

  @override
  State<P3> createState() => _P3State();
}

class _P3State extends State<P3> {
  StreamController<String> ss = StreamController();
  // int i = 0;
  @override
  void dispose() {
    ss.close();
    // (Cfg().memoryPageViewDataObject[widget.name]).myTitle = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        StreamBuilder(
            stream: ss.stream,
            initialData: '---',
            builder: (context, snapshot) {
              return Text((Cfg().memoryPageViewDataObject[widget.name]) == null
                  ? ""
                  : (Cfg().memoryPageViewDataObject[widget.name]).myTitle);
            }),
        Text('页面p3'),
        TextButton.icon(
            onPressed: ff, icon: Icon(Icons.abc), label: Text('测试持久化value'))
      ],
    ));
  }

  void ff() {
    (Cfg().memoryPageViewDataObject[widget.name]).myTitle =
        '值:' + (Cfg().memoryPageViewDataObject[widget.name]).i.toString() + '';
    ss.add((Cfg().memoryPageViewDataObject[widget.name]).myTitle);

    (Cfg().memoryPageViewDataObject[widget.name]).i++;
  }
}
