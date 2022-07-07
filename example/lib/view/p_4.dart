import 'package:flutter/material.dart';
import 'package:mtest/component/values/values.dart';
import 'package:myplus/myplus.dart';

// ValueKey:以一个值为key。
// ObjectKey:以一个对象为key。
// UniqueKey:生成唯一的随机数作为key。
// PageStorageKey:专用于存储页面滚动位置的key。
// GlobalKey:见下一节。

class P4Data implements DataBase {
  var a = 'abc';
  var testint = 0;
  var editText = '解锁新技能';
  @override
  void destroy() {
    a = 'abc';
    testint = 0;
    editText = '解锁新技能';
  }
}

class P4 extends StatefulWidget {
  P4(
    this.name, {
    Key? key,
  }) : super(key: key);
  String name = '';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<P4> {
  int counter = 0;
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: m(widget.name).editText);
  }

  void _incrementCounter() {
    setState(() {
      counter++;
      m(widget.name).testint = counter;
      m(widget.name).editText = _controller.text;
      m(widget.name).a = _controller.text;
      // _controller.text = counter.toString();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('chanage.....');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff5f5f5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              alignment: Alignment.bottomCenter,
              child: const Text(
                '框架方法',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  height: 1.3,
                ),
              ),
            ),
            const Spacer(),
            Text(
              '切换页面观察值变化--${m(widget.name).testint}',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 4,
                child: TextFormField(
                  controller: _controller,
                  onChanged: (v) {
                    m(widget.name).editText = v;
                  },
                )),
            Text(m(widget.name) == null ? '' : m(widget.name).a),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const Spacer(),
          ],
        ),
        // ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
