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
  @override
  void dispose() {
    ss.close();
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
              return Text(m(widget.name) == null ? "" : m(widget.name).myTitle);
            }),
        const SizedBox(
          width: 50,
        ),
        OutlinedButton.icon(onPressed: ff, icon: const Icon(Icons.abc), label: const Text('测试持久化value')),
      ],
    ));
  }

  void ff() {
    m(widget.name).myTitle = '值:' + m(widget.name).i.toString() + '';
    ss.add(m(widget.name).myTitle);

    m(widget.name).i++;
  }
}
