import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mtest/plug/toast/lib/toast.dart';
import 'package:myplus/myplus.dart';

import 'view/BaseView/searchbar_delegate.dart';
import 'view_config/page_config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamController<bool> _controler1;
  var ratio = 1;
  @override
  void initState() {
    super.initState();
    _controler1 = StreamController.broadcast();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var expandFlag = true;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                searchList.clear();
                Mgr().leafNodes.forEach((element) {
                  searchList.add(element.name);
                });
                recentSuggest.clear();
                recentSuggest.add(searchList[0]);
                recentSuggest.add(searchList[1]);
                showSearch(context: context, delegate: SearchBarDelegate());
              },
            )
          ],
          leading: Row(
            children: [
              StreamBuilder(
                  initialData: true,
                  stream: _controler1.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return IconButton(
                      icon: snapshot.data
                          ? const Icon(Icons.keyboard_arrow_left)
                          : const Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        expandFlag
                            ? Mgr().ratioControler.add(0.0001)
                            : Mgr().ratioControler.add(Mgr().ratio);
                        expandFlag = !expandFlag;
                        _controler1.sink.add(expandFlag);
                      },
                    );
                  }),
            ],
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: const Color(0xff777777),
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),

        // appBar: PreferredSize(
        //     preferredSize: const Size.fromHeight(30.0),
        //     child: AppBar(
        //       automaticallyImplyLeading: false,
        //       elevation: 1.5,
        //       backgroundColor: const Color(0xff28c0C6),
        //       title: const Text(
        //         'flutter企业级应用框架',
        //         style: AppTheme.caption,
        //       ),
        //     )),
        body: TreeEntry(rootNode));
  }
}
