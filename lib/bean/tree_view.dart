import 'package:flutter/material.dart';

import 'ObjectBean.dart';
import 'leaf_item.dart';
import 'tree_node.dart';
import 'cfg.dart';

typedef fcb = void Function(String name);

class TreeView extends StatefulWidget {
  const TreeView(this.organs, {Key? key}) : super(key: key);
  final List<Node> organs;
  @override
  State<TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  @override
  void initState() {
    TreeNodes().dataParses(widget.organs);
    TreeNodes().init();
    super.initState();
  }

  List<Widget> _buildNode(List<TreeNode> nodes) {
    var widgets = <Widget>[];
    if (nodes.isNotEmpty) {
      for (TreeNode node in nodes) {
        widgets.add(GestureDetector(
          child: LeafItem(
            node.isLeaf
                ? "images/member.png"
                : node.expand
                    ? "images/expand.png"
                    : "images/collect.png",
            node.isLeaf
                ? (node.object as LeafNode).name
                : (node.object as Node).name,
            // left: node.depth * 20.0,
          ),
          onTap: () {
            node.isLeaf
                ? {
                    Cfg().savePageView(
                        (node) => btnWidget((node.object as LeafNode).name,
                            openViewPage, delViewPage),
                        node),
                    // 页面跳转
                    Cfg().setPageView((node.object as LeafNode).name),
                  }
                : {
                    if (node.expand)
                      {node.expand = false, TreeNodes().collapse(node.nodeId)}
                    else
                      {node.expand = true, TreeNodes().expand(node.nodeId)},
                  };

            Cfg().updateUi();
          },
        ));
      }
    }
    return widgets;
  }

  void openViewPage(name) {
    Cfg().setPageView(name);
    Cfg().updateUi();
  }

  void delViewPage(name) {
    Cfg().delPageView(name);
    Cfg().updateUi();
  }

  Widget btnWidget(name, fcb openViewPage, fcb delViewPage) {
    double iconSize = Cfg().titleBtn / 2;
    return Container(
      height: Cfg().titleBtn,
      margin: const EdgeInsets.only(left: 10.0),
      decoration: const BoxDecoration(
        color: Colors.tealAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // border: Border.all(color: const Color.fromARGB(255, 138, 97, 97), width: 1)
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: () {
                openViewPage(name);
              },
              child: Text(
                name,
                style: const TextStyle(color: Colors.black87),
              )),
          IconButton(
              onPressed: () {
                delViewPage(name);
              },
              icon: Icon(
                Icons.close,
                size: iconSize,
              )),
        ],
      ),
      // color: Colors.greenAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build.........');
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Cfg().title == '' ? Container() : Text(Cfg().title),
          StreamBuilder<Cfg>(
            stream: Cfg().streamController.stream,
            initialData: Cfg(),
            builder: (context, snapshot) {
              return Cfg().title == ''
                  ? Container()
                  : Text(snapshot.data!.title);
            },
          ),
          TextButton(
              onPressed: () {
                Cfg().title = 'eeee';
                Cfg().updateUi();
              },
              child: Text("没毛病老铁")),
          Expanded(
            child: Row(children: [
              //左树 右pageView
              Expanded(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Cfg().leftPanelColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: StreamBuilder(
                          stream: Cfg().streamController.stream,
                          builder: (context, snapshot) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: _buildNode(TreeNodes().expandItem));
                          }),
                    ),

                    //-------------------------------
                    Expanded(
                        child: Container(
                      color: Cfg().rightPanelColor,
                      height: double.infinity,
                      child: StreamBuilder(
                        stream: Cfg().streamController.stream,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              Container(
                                  height: Cfg().titleHeight,
                                  decoration: BoxDecoration(
                                    color: Cfg().titlePanelColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                  ),
                                  child: Row(
                                    children: [
                                      //标题快捷按钮
                                      for (var i = 0;
                                          i <
                                              Cfg()
                                                  .memoryPageViewAction
                                                  .values
                                                  .toList()
                                                  .length;
                                          i++)
                                        Cfg()
                                            .memoryPageViewAction
                                            .values
                                            .toList()[i],
                                    ],
                                  )),
                              Expanded(
                                  child: Cfg().memoryPageView[
                                          Cfg().pageViewIndex] ??
                                      Container()),
                            ],
                          );
                        },
                      ),
                    )),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
