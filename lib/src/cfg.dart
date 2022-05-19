import 'dart:async';

import 'package:flutter/material.dart';

import 'object_bean.dart';

class Cfg {
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

  var rightPanelColor = Colors.deepOrange[50];
  var leftPanelColor = Colors.deepOrange[100];
  var titlePanelColor = Colors.deepOrange;
  var titleHeight = 40.0;
  double titleBtn = 30.0;

  delPageView(name) {
    memoryPageView.remove(name);
    memoryPageViewAction.remove(name);
    memoryPageViewDataObject.update(name, (value) {
      // if ((value != null) && (value.restore != null)) {
      if ((value != null)) {
        if (value.restore() != null) {
          value.restore();
        }
      }
    });
    memoryPageViewDataObject.remove(name);
    pageViewIndex =
        memoryPageView.isEmpty ? pageViewIndex : memoryPageView.keys.last;
    // memoryPageView.remove(name);
    // memoryPageViewAction.remove(name);
    // pageViewIndex =
    //     memoryPageView.isEmpty ? pageViewIndex : memoryPageView.keys.last;
  }

  setPageView(name) {
    pageViewIndex = name;
  }

  savePageView(Widget titleWideget(node), node) {
    // if (memoryPageView.containsKey((node.object as LeafNode).btnCaption)) {
    // } else {
    //   //pageView
    //   memoryPageView.putIfAbsent((node.object as LeafNode).btnCaption,
    //       () => (node.object as LeafNode).object);
    //   //title button
    //   memoryPageViewAction.putIfAbsent(
    //       (node.object as LeafNode).btnCaption, () => titleWideget(node));
    // }
    if (memoryPageView.containsKey((node.object as LeafNode).btnCaption)) {
    } else {
      //pageView
      memoryPageView.putIfAbsent((node.object as LeafNode).btnCaption,
          () => (node.object as LeafNode).object);
      //title button
      memoryPageViewAction.putIfAbsent(
          (node.object as LeafNode).btnCaption, () => titleWideget(node));
    }

    ///持久化 memoryPageViewDataObject
    if (memoryPageViewDataObject
        .containsKey((node.object as LeafNode).btnCaption)) {
    } else {
      memoryPageViewDataObject.putIfAbsent(
          (node.object as LeafNode).btnCaption, () => node.object.clas);
    }
  }

  updateUi() {
    Cfg().streamController.add(Cfg());
  }
}
