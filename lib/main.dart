import 'package:flutter/material.dart';

import 'cfg.dart';
import 'tree_view_xe.dart';

void main() {
  runApp(const MyApp());
}

final leafPageView = <String, Widget>{
  '按钮1': const P1(),
  '按钮2': const P2(),
  '按钮3': const P3(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cfg().setLeafNode = Map<String, Widget>.from(leafPageView);
    Cfg().title = '世界上最简单的树';
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'aa'),
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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const TreeViewXe());
  }
}

class P1 extends StatelessWidget {
  const P1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('p1'),
    );
  }
}

class P2 extends StatelessWidget {
  const P2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('P2'),
    );
  }
}

class P3 extends StatelessWidget {
  const P3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('p3'),
    );
  }
}
