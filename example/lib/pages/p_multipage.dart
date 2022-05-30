import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Mdata {
  Mdata._() {
    _h = this;
  }
  String str = '';
  static Mdata? _h;
  factory Mdata() {
    return _h ??= Mdata._();
  }
}

late StreamController sc;

class PMultipage extends StatelessWidget {
  const PMultipage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  ScrollController scrollController = ScrollController();
  int _counter = 0;
  bool isPressed = false;
  bool _isScrollingDown = false;
  ScrollController _scrollController = ScrollController();

  final List<String> _sectionsName = ["f1", "f2"];
  final List<IconData> _sectionsIcons = [
    Icons.person,
    Icons.home,
  ];
  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  void _scroll(int i) {
    _scrollController.animateTo(
      i == 0
          ? 0.0
          : i == 1
              ? MediaQuery.of(context).size.height * 1.05
              : i == 2
                  ? MediaQuery.of(context).size.height * 1.98
                  : i == 3
                      ? MediaQuery.of(context).size.height * 2.9
                      : MediaQuery.of(context).size.height * 4,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Widget sectionWidget(int i) {
    if ((i == 0)) {
      return F1();
    } else if (i == 1) {
      return F2();
    } else {
      return Container(
        child: Text('没有更多！'),
      );
    }
  }

  @override
  void initState() {
    sc = StreamController<Mdata>.broadcast();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!_isScrollingDown) {
          _isScrollingDown = true;
          setState(() {});
        }
      }

      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (_isScrollingDown) {
          _isScrollingDown = false;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Mdata().str = 'abc';
                sc.add(Mdata());
              },
              child: Text('wenben')),
          //Stack(children: [
          SectionsBody(
            scrollController: _scrollController,
            sectionsLength: _sectionsIcons.length,
            sectionWidget: sectionWidget,
          )
        ],
      ),
      //])
    );
  }
}

class F1 extends StatefulWidget {
  F1({Key? key}) : super(key: key);

  @override
  State<F1> createState() => _F1State();
}

class _F1State extends State<F1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          StreamBuilder(
            stream: sc.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Text((snapshot.data as Mdata).str);
              } else {
                return Text('data');
              }
            },
          ),
        ],
      ),
    );
  }
}

class F2 extends StatefulWidget {
  F2({Key? key}) : super(key: key);

  @override
  State<F2> createState() => _F2State();
}

class _F2State extends State<F2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            StreamBuilder(
              stream: sc.stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Text((snapshot.data as Mdata).str);
                } else {
                  return Text('data111111111111');
                }
                // // if (snapshot.hasData) {
                // return Text('${(snapshot.data as Mdata).str}--------');
                // // } else return const Text('data');
              },
            ),
          ],
        ));
  }
}

class SectionsBody extends StatelessWidget {
  final ScrollController scrollController;
  final int sectionsLength;
  final Widget Function(int) sectionWidget;

  const SectionsBody({
    Key? key,
    required this.scrollController,
    required this.sectionsLength,
    required this.sectionWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        // physics: !kIsWeb ? ScrollPhysics() : NeverScrollableScrollPhysics(),
        controller: scrollController,
        itemCount: sectionsLength,
        itemBuilder: (context, index) => sectionWidget(index),
      ),
    );
  }
}
