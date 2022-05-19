import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myplus/myplus.dart';

import 'p_1.dart';
import 'p_2.dart';
import 'p_3.dart';
import 'p_4.dart';

const K4 = '按钮4';

class P4Data implements DataBase {
  var a = 'abc';
  var testint = 0;
  var editText = '解锁新技能';
  @override
  void restore() {
    a = 'abc';
    testint = 0;
    editText = '解锁新技能';
  }
}

class P3Data implements DataBase {
  var myTitle = 'mytitile';
  int i = 0;
  @override
  void restore() {
    myTitle = 'mytitile';
    i = 0;
  }
}

class P1Data {
  @override
  noSuchMethod(Invocation invocation) {
    print('缺少restore方法');
  }
}

var two = [
  Node([], [
    LeafNode(P1('按钮1'), btnCaption: "按钮1", clas: P1Data()),
  ], "二级机构"),
];
var root = [
  Node([
    ...two
  ], [
    LeafNode(const P2(), btnCaption: "按钮2"),
    LeafNode(P3('按钮3'), btnCaption: "按钮3", clas: P3Data()),
    //持久化数据
    LeafNode(P4(K4), btnCaption: K4, clas: P4Data()),
  ], "一级机构"),
];

void main() {
  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cfg().title = '世界上最容易使用的树';
    // Cfg().rightPanelColor = Colors.red;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '世界上最简单易使用的框架'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              elevation: 1.5,
              // backgroundColor: Colors.black,
              title: Text(widget.title),
            ),
            preferredSize: const Size.fromHeight(30.0)),
        body: TreeView(root));
  }
}
