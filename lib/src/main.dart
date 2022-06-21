import 'dart:async';
import 'package:flutter/material.dart';

import 'entity.dart';
import 'node_view.dart';
import 'node_data.dart';
import 'mgr.dart';

late ScrollController _scrollController;
late ScrollController _scrollController2;

class TreeEntry extends StatefulWidget {
  const TreeEntry(this.directoryNodes, {Key? key}) : super(key: key);
  final List<DirectoryNode> directoryNodes;
  @override
  State<TreeEntry> createState() => _TreeEntryState();
}

class _TreeEntryState extends State<TreeEntry> {
  var selectedNodeName = '';
  var selectedColor = Colors.blue[200];
  var unSelectedColor = Colors.white;
  late StreamController<String> toolbarColorChangeNotify;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController.addListener(() {});
    _scrollController2.addListener(() {});
    toolbarColorChangeNotify = StreamController<String>.broadcast();
    NodesDatas().loadData(widget.directoryNodes);
    if (Mgr().isAllExpanded) {
      // 全部展开
      NodesDatas().expandAll();
    } else {
      NodesDatas().init();
    }
    // TreeNodes().expand(1);
    // TreeNodes().expandAll();
    super.initState();
  }

  List<Widget> _buildNode(List<NodeData> nodes) {
    var widgets = <Widget>[];
    if (nodes.isNotEmpty) {
      for (NodeData node in nodes) {
        widgets.add(
          //
          NodeView(
            node.isLeaf

                ///选中 图标与字体一起变色
                ? (node.object is LeafNode) && (node.object as LeafNode).name == selectedNodeName
                    ? (node.object as LeafNode).selectedIcon ??
                        const Icon(
                          Icons.brightness_1,
                          color: Colors.green, // Color(0xff28c0C6),
                          size: 12,
                        )
                    : (node.object as LeafNode).unSelectedIcon ??
                        const Icon(
                          Icons.brightness_1_sharp,
                          color: Color(0xff28c0C6),
                          size: 12,
                        )

                ///目录节点  开合图标
                : node.isExpanded
                    ? node.directorySelectedIcon ??
                        const Icon(
                          Icons.keyboard_arrow_up,
                          size: 20,
                          color: Colors.green,
                        )
                    : node.directoryUnSelectedIcon ?? const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xff28c0C6)),

            ///name     页节点 目录节点 名称 与颜色
            node.isLeaf ? (node.object as LeafNode).name : (node.object as DirectoryNode).name,

            ///  bgColor
            (node.object is LeafNode) && (node.object as LeafNode).name == selectedNodeName ? selectedColor : unSelectedColor,

            ///
            textColor: (node.object is LeafNode) && (node.object as LeafNode).name == selectedNodeName ? Colors.white : const Color(0xFF253840),
            itemOnTap, node,

            ///节点是叶节点还是目录节点
            isLeaf: node.isLeaf ? true : false,

            ///树缩进
            // left: (node.object is LeafNode) ? node.depth * 20.0 : 0,
          ),
        );
      }
    }
    return widgets;
  }

  void itemOnTap(NodeData<dynamic> node) {
    node.isLeaf
        ? {
            Mgr().savePage((node) => pressButton(node, (node.object as LeafNode).name, openPage, delPage), node),
            selectedNodeName = (node.object as LeafNode).name,
            Mgr().shareKey = selectedNodeName,

            ///选中节点消息通知
            toolbarColorChangeNotify.add(selectedNodeName),
          }
        : {
            if (node.isExpanded) {node.isExpanded = false, NodesDatas().collapse(node.nodeId)} else {node.isExpanded = true, NodesDatas().expand(node.nodeId)},
          };

    Mgr().notifyUi();
  }

  void openPage(name) {
    Mgr().shareKey = name;
    Mgr().notifyUi();
  }

  Future<void> delPage(name) async {
    await Mgr().delPage(name).then((value) => selectedNodeName = value);

    toolbarColorChangeNotify.add(selectedNodeName);
    Mgr().notifyUi();
  }

  @override
  void dispose() {
    toolbarColorChangeNotify.close();
    super.dispose();
  }

  ///导航按钮
  Widget pressButton(node, name, openViewPage, delViewPage) {
    Color? overlayColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.focused)) {
        return Colors.grey.withOpacity(0.8);
      }
      if (states.contains(MaterialState.hovered)) {
        return selectedColor;
      }
      return null; // defer to the default overlayColor
    }

    Color? foregroundColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.hovered)) {
        return Colors.white;
      }
      return null; // defer to the default foregroundColor
    }

    return StreamBuilder(
      stream: toolbarColorChangeNotify.stream,
      builder: (_, __) {
        /// 消息发来的 当前按钮信息 进行绘制
        return Container(
          ///每个按钮限制的高度
          height: 30.0 * 0.8,

          margin: const EdgeInsets.only(left: 6.0, right: 6.0),
          decoration: BoxDecoration(
            color: name == selectedNodeName ? selectedColor : Colors.deepOrange[100],
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(clipBehavior: Clip.none, fit: StackFit.loose, children: [
                Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.resolveWith<Color?>(overlayColor),
                            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                              foregroundColor,
                            ),
                            //圆角
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                            //边框
                            // side: MaterialStateProperty.all(
                            //   const BorderSide(color: Colors.red, width: 0.67),
                            // ),
                            //背景
                            backgroundColor: MaterialStateProperty.all(Colors.transparent)),
                        child: Text(
                          name,
                          style: const TextStyle(fontFamily: 'WorkSans', letterSpacing: 0.2, fontWeight: FontWeight.w400, color: Color(0xFF4A6572), fontSize: 12),
                        ),
                        onPressed: () {
                          openViewPage(name);
                          selectedNodeName = name;
                          try {
                            toolbarColorChangeNotify.add(name);
                          } catch (_) {
                            print('Widget 定义去掉back按钮');
                          }
                        })),
                Positioned(
                  top: -10,
                  right: -12,
                  child: Material(
                      child:

                          ///
                          // CircleAvatar(
                          //     radius: 10,
                          //     backgroundColor: Colors.red,
                          //     child:

                          ///
                          IconButton(
                              color: Colors.white,
                              onPressed: () {
                                delViewPage(name);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 10,
                                // size: iconSize,
                              ))

                      ///
                      // )
                      //
                      ),
                ),
              ]),

              // const VerticalDivider(
              //   color: Colors.yellow,
              //   width: 5,
              // )
            ],
          ),
          // color: Colors.greenAccent,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
        //左树 右pageView
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          child: StreamBuilder(

              ///画树
              stream: Mgr().outer,
              builder: (context, snapshot) {
                return Column(children: _buildNode(NodesDatas().expandNodes));
              }),
        ),
        SizedBox(
          width: 2,
          child: VerticalDivider(
            thickness: 1,
            indent: 0, //起点缩进距离
            endIndent: 0, //终点缩进距离
            color: Colors.red.withOpacity(0.6), //是指分割线颜色
          ),
        ),

        ///
        Expanded(
            child: Container(
          color: Mgr().rightPanelColor,
          height: double.infinity,
          child: StreamBuilder(
            ///画toolbar
            stream: Mgr().outer,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Container(
                      height: Mgr().toolbarHeight,
                      decoration: BoxDecoration(
                        color: Mgr().toolbarColor,
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                      ),

                      ///创建快捷button
                      child: SingleChildScrollView(
                        controller: _scrollController2,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            //标题快捷按钮
                            for (var i = 0; i < Mgr().vWidgetAction.values.toList().length; i++) Mgr().vWidgetAction.values.toList()[i],
                          ],
                        ),
                      )
                      //)

                      ///
                      ),
                  Expanded(child: Mgr().vWidget[Mgr().shareKey] ?? Container()),
                ],
              );
            },
          ),
        ))
      ]),
    );
  }
}
