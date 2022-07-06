import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myplus/myplus.dart';

class P3Data implements DataBase {
  var myTitle = 'mytitile';
  int i = 0;

  /// 数据还原
  @override
  void destroy() {
    myTitle = 'mytitile';
    i = 0;
  }
}

class P3 extends StatefulWidget {
  P3(this.name, {Key? this.key}) : super(key: key);

  String name = '';

  Key? key;

  @override
  State<P3> createState() => _P3State();
}

class _P3State extends State<P3> {
  StreamController<String> ss = StreamController();
  P3Data? p3_data;
  @override
  void dispose() {
    ss.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    var tt =
        PageStorage.of(context)!.readState(context, identifier: widget.key);
    if (tt != null) {
      p3_data = tt;
    } else {
      p3_data = P3Data();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
              stream: ss.stream,
              initialData: '---',
              builder: (context, snapshot) {
                return Text(p3_data == null ? "" : p3_data!.myTitle);
                //  return Text(m(widget.name) == null ? "" : m(widget.name).myTitle);
              }),
          const SizedBox(
            width: 50,
          ),
          OutlinedButton.icon(
              onPressed: () {
                ///框架自带方法 数据持久化
                // m(widget.name).myTitle = '值:' + m(widget.name).i.toString() + '';

                // ss.add(m(widget.name).myTitle);

                //m(widget.name).i++;

                ///系统自带方法数据持久化
                p3_data!.myTitle = "我CAO " + p3_data!.i.toString();

                p3_data!.i++;
                ss.add(p3_data!.myTitle);

                PageStorage.of(context)!
                    .writeState(context, p3_data, identifier: widget.key);
              },
              icon: const Icon(Icons.abc),
              label: const Text('测试持久化value')),
        ],
      ),
    );
  }
}
