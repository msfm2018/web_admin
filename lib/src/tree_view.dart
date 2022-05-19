import 'package:flutter/material.dart';

import 'object_bean.dart';
import 'leaf_item.dart';
import 'tree_node.dart';
import 'cfg.dart';

typedef Fcb = void Function(String name);

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
    if (Cfg().allExpand) {
      // 全部展开
      TreeNodes().expandAll();
    } else {
      TreeNodes().init();
    }
    // TreeNodes().expand(1);
    // TreeNodes().expandAll();
    super.initState();
  }

  List<Widget> _buildNode(List<TreeNode> nodes) {
    var widgets = <Widget>[];
    if (nodes.isNotEmpty) {
      for (TreeNode node in nodes) {
        widgets.add(GestureDetector(
          child: LeafItem(
            node.isLeaf
                ? const Icon(Icons.arrow_right, size: 20)
                : node.expand
                    ? const Icon(Icons.arrow_circle_up_sharp, size: 20)
                    : const Icon(Icons.arrow_circle_down_sharp, size: 20),
            node.isLeaf
                ? (node.object as LeafNode).btnCaption
                : (node.object as Node).name,
            // left: node.depth * 20.0,
          ),
          onTap: () {
            node.isLeaf
                ? {
                    Cfg().savePageView(
                        (node) => btnWidget(
                            node,
                            (node.object as LeafNode).btnCaption,
                            openViewPage,
                            delViewPage),
                        node),
                    // 页面跳转
                    Cfg().setPageView((node.object as LeafNode).btnCaption),
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
    // Cfg().memoryPageViewDataObject.remove(name);

    Cfg().updateUi();
  }

  Widget btnWidget(node, name, Fcb openViewPage, Fcb delViewPage) {
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
          const SizedBox(
            width: 2,
          ),
          TextButton(
              style: ButtonStyle(
                  //圆角
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.67))),
                  //边框
                  side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.red, width: 0.67),
                  ),
                  //背景
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
              child: Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 14),
              ),
              onPressed: () {
                openViewPage(name);
              }),
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
    return Container(
      color: Colors.white,
      child: Column(
        children: [
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
                Cfg().title = '没毛病老铁';
                Cfg().updateUi();
              },
              child: Text("修改")),
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
