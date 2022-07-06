import 'package:flutter/material.dart';

import '../component/keep_alive_wrapper.dart';

class KeepLive extends StatefulWidget {
  const KeepLive({Key? key}) : super(key: key);

  @override
  State<KeepLive> createState() => _KeepLiveState();
}

class _KeepLiveState extends State<KeepLive> {
  @override
  Widget build(BuildContext context) {
    return TextField();
  }
}

class SAreaAgeGenderMain extends StatefulWidget {
  const SAreaAgeGenderMain({Key? key}) : super(key: key);

  @override
  _SAreaAgeGenderMainState createState() => _SAreaAgeGenderMainState();
}

class _SAreaAgeGenderMainState extends State<SAreaAgeGenderMain> {
//
  bool isPointRadiusMapper = false;
  late List<Tab> tabList;
  late List<Widget> tabViewList;

  @override
  void initState() {
    super.initState();
    tabList = [
      Tab(text: '页面1'),
      Tab(text: '页面2'),
    ];
    tabViewList = [
      const KeepAliveWrapper(child: KeepLive()),
      const KeepAliveWrapper(child: KeepLive()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var tabBar = TabBar(
      isScrollable: false,
      tabs: tabList,
      indicatorColor: Colors.green,
      labelColor: Colors.black,
    );
    var result = Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: tabList.length,
        child: Column(
          children: [
            tabBar,
            Expanded(child: TabBarView(children: tabViewList)),
          ],
        ),
      ),
    );
    return result;
  }
}
