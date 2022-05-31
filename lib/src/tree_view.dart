import 'dart:async';
import 'package:flutter/material.dart';

import 'object_bean.dart';
import 'leaf_item.dart';
import 'tree_node.dart';
import 'tree.dart';

typedef Fcb = void Function(String name);
late ScrollController _scrollController;

class TreeView extends StatefulWidget {
  const TreeView(this.organs, {Key? key}) : super(key: key);
  final List<DirectoryNode> organs;
  @override
  State<TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  var selectName = '';
  var selectColor = Colors.blue;
  var unSelectColor = Colors.grey; // Colors.black;
  late StreamController<String> selectControl;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print('_scrollController ${_scrollController.offset}');
    });
    selectControl = StreamController<String>.broadcast();
    TreeNodes().dataParses(widget.organs);
    if (Trees().allExpand) {
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
        widgets.add(
          //
          LeafItem(
            node.isLeaf

                ///选中 图标与字体一起变色
                ? (node.object is LeafNode) && (node.object as LeafNode).leafName == selectName
                    ? (node.object as LeafNode).leafSelectedIcon ??
                        const Icon(
                          Icons.description_outlined,
                          size: 20,
                          // color: selectColor,
                        )
                    : (node.object as LeafNode).leafUnSelectedIcon ??
                        const Icon(
                          Icons.description_outlined,
                          size: 20,
                          // color: unSelectColor,
                        )

                ///目录开合图标
                : node.expand
                    ? node.dirSelectIcon ?? const Icon(Icons.swap_vert_circle_outlined, size: 20)
                    : node.dirUnSelectIcon ?? const Icon(Icons.arrow_circle_down_sharp, size: 20),

            ///name     页节点 目录节点 名称 与颜色
            node.isLeaf ? (node.object as LeafNode).leafName : (node.object as DirectoryNode).name,

            ///  bgColor
            (node.object is LeafNode) && (node.object as LeafNode).leafName == selectName ? selectColor : unSelectColor,

            ///
            textColor: (node.object is LeafNode) && (node.object as LeafNode).leafName == selectName ? selectColor : unSelectColor,
            itemOnTap, node,

            ///树缩进
            // left: (node.object is LeafNode) ? node.depth * 20.0 : 0,
            left: (node.object is LeafNode) ? 20.0 : 0,
          ),
        );
      }
    }
    return widgets;
  }

  void itemOnTap(TreeNode<dynamic> node) {
    node.isLeaf
        ? {
            Trees().savePageView((node) => pressButton(node, (node.object as LeafNode).leafName, openViewPage, delViewPage), node),
            selectName = (node.object as LeafNode).leafName,
            selectControl.add(selectName),
            // 页面跳转
            Trees().setPageView((node.object as LeafNode).leafName),
          }
        : {
            if (node.expand) {node.expand = false, TreeNodes().collapse(node.nodeId)} else {node.expand = true, TreeNodes().expand(node.nodeId)},
          };

    Trees().notifyUi();
  }

  void openViewPage(name) {
    Trees().setPageView(name);
    Trees().notifyUi();
  }

  void delViewPage(name) {
    Trees().delPageView(name);
    selectName = Trees().pageViewIndex;
    selectControl.add(selectName);
    Trees().notifyUi();
  }

  @override
  void dispose() {
    selectControl.close();
    super.dispose();
  }

  ///导航按钮
  Widget pressButton(node, name, Fcb openViewPage, Fcb delViewPage) {
    double iconSize = Trees().titleBtn / 4;

    Color? overlayColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.focused)) {
        return Colors.grey.withOpacity(0.8);
      }
      if (states.contains(MaterialState.hovered)) {
        return selectColor;
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
      stream: selectControl.stream,
      // initialData: 'initvalue',
      builder: (a, b) {
        return Container(
          height: Trees().titleBtn,
          margin: const EdgeInsets.only(left: 6.0, right: 6.0),
          decoration: BoxDecoration(
            color: name == selectName ? selectColor : Colors.deepOrange[100],
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(overlayColor),
                      foregroundColor: MaterialStateProperty.resolveWith<Color?>(foregroundColor),
                      //圆角
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.67))),
                      //边框
                      side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.red, width: 0.67),
                      ),
                      //背景
                      backgroundColor: MaterialStateProperty.all(Colors.transparent)),
                  child: Text(
                    name,
                    style: const TextStyle(fontFamily: 'WorkSans', letterSpacing: 0.2, fontWeight: FontWeight.w400, color: Color(0xFF4A6572), fontSize: 12),
                  ),
                  onPressed: () {
                    openViewPage(name);
                    selectName = name;
                    selectControl.add(name);
                  }),
              IconButton(
                  onPressed: () {
                    delViewPage(name);
                  },
                  icon: Icon(
                    Icons.close,
                    size: iconSize,
                  )),
              const VerticalDivider(
                color: Colors.grey,
                width: 1,
              )
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
      child: Column(
        children: [
          ///上  header
          const SizedBox(
            height: 4,
          ),
          StreamBuilder<Trees>(
            stream: Trees().streamController.stream,
            initialData: Trees(),
            builder: (context, snapshot) {
              return Trees().title.isEmpty ? Container() : Text(snapshot.data!.title);
            },
          ),
          // 测试
          // Cfg().title.isEmpty
          //     ? const SizedBox()
          //     : TextButton(
          //         onPressed: () {
          //           Cfg().title = '没毛病老铁';
          //           Cfg().updateUi();
          //         },
          //         child: const Text("修改")),

          // 下

          Expanded(
            child: Row(children: [
              //左树 右pageView
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController,
                      child: Column(
                        children: [
                          StreamBuilder(
                              stream: Trees().streamController.stream,
                              builder: (context, snapshot) {
                                return Column(mainAxisAlignment: MainAxisAlignment.start, children: _buildNode(TreeNodes().expandNodes));
                              }),
                        ],
                      ),
                    ),
                    // const VerticalDivider(),
                    const SizedBox(
                      width: 20,
                      child: VerticalDivider(
                        thickness: 1,
                        indent: 0, //起点缩进距离
                        endIndent: 0, //终点缩进距离
                        color: Colors.redAccent, //是指分割线颜色
                      ),
                    ),

                    //-------------------------------
                    Expanded(
                        child: Container(
                      color: Trees().rightPanelColor,
                      height: double.infinity,
                      child: StreamBuilder(
                        stream: Trees().streamController.stream,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              Container(
                                  height: Trees().titleHeight,
                                  decoration: BoxDecoration(
                                    color: Trees().titlePanelColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                                  ),

                                  ///创建快捷button
                                  child: Scrollbar(
                                      child: SingleChildScrollView(
                                    primary: true,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        //标题快捷按钮
                                        for (var i = 0; i < Trees().memoryPageViewAction.values.toList().length; i++) Trees().memoryPageViewAction.values.toList()[i],
                                      ],
                                    ),
                                  ))

                                  ///
                                  ),
                              Expanded(child: Trees().memoryPageView[Trees().pageViewIndex] ?? Container()),
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
