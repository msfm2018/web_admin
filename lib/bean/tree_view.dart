import 'package:flutter/material.dart';

import 'ObjectBean.dart';
import 'leaf_item.dart';
import 'tree_node.dart';
import 'cfg.dart';

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
                    Cfg().memoryPageView.putIfAbsent(
                        (node.object as LeafNode).name,
                        () => (node.object as LeafNode).object),
                    Cfg().memoryPageViewAction.putIfAbsent(
                        (node.object as LeafNode).name,
                        () => Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 138, 97, 97),
                                      width: 1)),
                              child: Row(
                                children: [
                                  moveLeft(5.0),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          Cfg().setPageView(
                                              (node.object as LeafNode).name);
                                        });
                                      },
                                      child: Text(
                                        (node.object as LeafNode).name,
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Cfg().delPageView(
                                            (node.object as LeafNode).name);

                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.close)),
                                  moveLeft(5.0)
                                ],
                              ),
                            )),
                    // 页面跳转
                    Cfg().pageViewIndex = (node.object as LeafNode).name
                  }
                : {
                    if (node.expand)
                      {node.expand = false, TreeNodes().collapse(node.nodeId)}
                    else
                      {node.expand = true, TreeNodes().expand(node.nodeId)}
                  };

            setState(() {});
          },
        ));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Cfg().title == '' ? Container() : Text(Cfg().title),
          Expanded(
            child: Row(children: [
              //左树 右pageView
              Expanded(
                child: Row(
                  children: [
                    Container(
                      color: Cfg().leftPanelColor,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildNode(TreeNodes().expandItem)),
                    ),
                    Expanded(
                        child: Container(
                            color: Cfg().rightPanelColor,
                            height: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                    height: Cfg().titleHeight,
                                    decoration: BoxDecoration(
                                      color: Cfg().titlePanelColor,
                                      border: Border.all(
                                          color: Colors.black45, width: 1),
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
                            ))),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  SizedBox moveLeft(w) {
    return SizedBox(
      width: w,
    );
  }
}
