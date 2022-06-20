import 'package:flutter/material.dart';
import 'package:myplus/myplus.dart';

class P4 extends StatefulWidget {
  P4(
    this.name, {
    Key? key,
  }) : super(key: key);
  String name = '';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<P4> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  int counter = 0;
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    debugPrint('initState');
    print(m(widget.name));
    _controller = TextEditingController(text: m(widget.name).editText);
  }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print("lifeChanged $state");
  }

  void _incrementCounter() {
    setState(() {
      counter++;
      m(widget.name).testint = counter;
      m(widget.name).editText = _controller.text;
      m(widget.name).a = _controller.text;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('chanage.....');
  }

  @override
  Widget build(BuildContext context) {
    print('p-4');
    return Scaffold(
      appBar: AppBar(
        title: Text(m(widget.name) == null ? '' : m(widget.name).a),
        // title: Text('${Cfg().testint}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'OhMygod--${m(widget.name).testint}',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextFormField(
              controller: _controller,
              onChanged: (v) {
                m(widget.name).editText = v;
              },
              // initialValue: Cfg().editText, // 'TextFormField - $counter',
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    print('dispose p_4');
    WidgetsBinding.instance.removeObserver(this); //销毁
    _controller.dispose();

    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
