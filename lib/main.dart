import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bean/ObjectBean.dart';
import 'bean/cfg.dart';
import 'bean/tree_view.dart';
import 'p_1.dart';
import 'p_2.dart';
import 'p_3.dart';

var two = [
  Node([], [
    LeafNode("按钮1", const P1()),
  ], "二级机构"),
];
var root = [
  Node([
    ...two
  ], [
    LeafNode("按钮2", const P2()),
    LeafNode("按钮3", const P3()),
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
