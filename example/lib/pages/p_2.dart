import 'package:flutter/material.dart';

class P2 extends StatelessWidget {
  const P2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.orange, Colors.red],
          stops: <double>[0.0, 1.0],
        ),
      ),
      child: renderCover(), // const Center(child: Text('页面P2')),
    );
  }

  Widget renderCover() {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(8),
          ),
          child: Image.network(
            'https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2020/5/21/17232d3515fb637b~tplv-t2oaga2asx-zoom-in-crop-mark:1304:0:0:0.awebp',
            height: 200,
            fit: BoxFit.cover,
            // fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          left: 110,
          top: 100,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(80, 0, 0, 0),
                ],
              ),
            ),
            child: const ClipOval(
              ///图片占位
              child: FadeInImage(
                width: 160,
                height: 36,
                fit: BoxFit.contain,
                image: NetworkImage('https://img0.baidu.com/it/u=3828415487,808710726&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500'),
                placeholder: AssetImage('assets/images/bg.png'),
              ),
            ),
          ),
        ),
        const LearnExpansionPanelList(),
      ],
    );
  }
}

class LearnExpansionPanelList extends StatefulWidget {
  const LearnExpansionPanelList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LearnExpansionPanelList();
  }
}

class _LearnExpansionPanelList extends State<LearnExpansionPanelList> {
  var currentPanelIndex = 0; //设置-1默认全部闭合
  var mList = [];

  @override
  void initState() {
    super.initState();

    mList.add('点歌的人');
    mList.add('任素汐');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  currentPanelIndex = (currentPanelIndex != panelIndex ? panelIndex : 0);
                });
              },
              children: mList.asMap().values.map((e) {
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text('$e'),
                    );
                  },
                  body: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: ListBody(
                      children: <Widget>[
                        Text('这是标题$e的内容'),
                        e == '任素汐'
                            ? Text('')
                            : FadeInImage(
                                width: 160,
                                height: 360,
                                fit: BoxFit.contain,
                                image: NetworkImage('https://img0.baidu.com/it/u=3828415487,808710726&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500'),
                                placeholder: AssetImage('assets/images/bg.png'),
                              ),
                      ],
                    ),
                  ),
                  isExpanded: mList[currentPanelIndex] == e,
                );
              }).toList(),
            ),
            Text('拉一个好看点的吧，类似qq分组之类的'),
          ],
        ),
      ),
    );
  }
}
