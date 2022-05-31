import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'object_bean.dart';
import 'tree_node.dart';

typedef Wb<T> = Widget Function(T);

typedef itemOnTap = void Function(TreeNode<dynamic> node);

class Cfg extends State {
  Cfg._() {
    _h = this;
    memoryPageView = <String, Widget>{};
    memoryPageViewAction = <String, Widget>{};
    memoryPageViewDataObject = <String, dynamic>{};
    streamController = StreamController<Cfg>.broadcast();
  }

  static Cfg? _h;
  factory Cfg() {
    return _h ??= Cfg._();
  }

  bool allExpand = false;

  late StreamController<Cfg> streamController;

  ///页面临时pageView
  late Map<String, Widget> memoryPageView;

  ///数据Persistence持久化
  late Map<String, dynamic> memoryPageViewDataObject;

  ///内存节点快捷按钮
  late var memoryPageViewAction;
  String title = '';
  String pageViewIndex = '';

  var rightPanelColor = Colors.white;
  var leftPanelColor = Colors.white;
  var titlePanelColor = Colors.deepOrange[100];
  var titleHeight = 40.0;
  double titleBtn = 30.0;

  delPageView(name) {
    memoryPageView.remove(name);
    memoryPageViewAction.remove(name);
    memoryPageViewDataObject.update(name, (value) {
      if ((value != null)) {
        if (value.destroy() != null) {
          value.destroy();
        }
      }
    });
    memoryPageViewDataObject.remove(name);
    pageViewIndex = memoryPageView.isEmpty ? pageViewIndex : memoryPageView.keys.last;
  }

  setPageView(name) {
    pageViewIndex = name;
  }

  savePageView(Wb b, node) {
    if (memoryPageView.containsKey((node.object as LeafNode).leafName)) {
    } else {
      //pageView
      memoryPageView.putIfAbsent((node.object as LeafNode).leafName, () => (node.object as LeafNode).object);
      //title button
      memoryPageViewAction.putIfAbsent((node.object as LeafNode).leafName, () => b(node));
    }

    ///持久化 memoryPageViewDataObject
    if (memoryPageViewDataObject.containsKey((node.object as LeafNode).leafName)) {
    } else {
      memoryPageViewDataObject.putIfAbsent((node.object as LeafNode).leafName, () => node.object.clas);
    }
  }

  notifyUi() {
    Cfg().streamController.add(Cfg());
  }

  String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random r = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  @override
  Widget build(Object context) {
    return Container();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
