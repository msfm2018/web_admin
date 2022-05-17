import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

import 'ObjectBean.dart';

class Cfg {
  Cfg._() {
    _h = this;
    memoryPageView = <String, Widget>{};
    memoryPageViewAction = <String, Widget>{};

    streamController = StreamController<Cfg>.broadcast();
  }
  static Cfg? _h;
  factory Cfg() {
    return _h ??= Cfg._();
  }

  bool allExpand = false;

  late StreamController<Cfg> streamController;

  ///页面临时pageView
  late var memoryPageView;

  ///内存节点快捷按钮
  late var memoryPageViewAction;
  String title = '';
  String pageViewIndex = '';

  var rightPanelColor = Colors.deepOrange[50];
  var leftPanelColor = Colors.deepOrange[100];
  var titlePanelColor = Colors.deepOrange;
  var titleHeight = 40.0;
  double titleBtn = 30.0;

  delPageView(name) {
    memoryPageView.remove(name);
    memoryPageViewAction.remove(name);
    pageViewIndex =
        memoryPageView.isEmpty ? pageViewIndex : memoryPageView.keys.last;
  }

  setPageView(name) {
    pageViewIndex = name;
  }

  savePageView(Widget titleWideget(node), node) {
    //pageView
    memoryPageView.putIfAbsent(
        (node.object as LeafNode).name, () => (node.object as LeafNode).object);
    //title button
    memoryPageViewAction.putIfAbsent(
        (node.object as LeafNode).name, () => titleWideget(node));
  }

  updateUi() {
    Cfg().streamController.add(Cfg());
  }
}
