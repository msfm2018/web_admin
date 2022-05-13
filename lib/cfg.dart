import 'package:flutter/material.dart';

class Cfg {
  Cfg._() {
    _h = this;
    memoryLeafNode = <String, Widget>{};
    _leafNode = <String, Widget>{};
    memoryLeafAction = <String, Widget>{};
  }
  static Cfg? _h;
  factory Cfg() {
    return _h ??= Cfg._();
  }
  set setLeafNode(v) {
    _leafNode = v;
    // memoryLeafNode = Map<String, Widget>.from(_leafNode);
  }

  get getLeafNode => _leafNode;

  ///叶子节点
  late var _leafNode;

  ///页面临时pageView
  late var memoryLeafNode;

  ///内存节点快捷按钮
  late var memoryLeafAction;
  String title = '';
  String pageViewIndex = '';
}
