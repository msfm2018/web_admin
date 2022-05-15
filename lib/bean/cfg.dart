import 'package:flutter/material.dart';

class Cfg {
  Cfg._() {
    _h = this;
    memoryPageView = <String, Widget>{};
    memoryPageViewAction = <String, Widget>{};
  }
  static Cfg? _h;
  factory Cfg() {
    return _h ??= Cfg._();
  }

  ///页面临时pageView
  late var memoryPageView;

  ///内存节点快捷按钮
  late var memoryPageViewAction;
  String title = '';
  String pageViewIndex = '';

  var rightPanelColor = Color.fromARGB(127, 255, 255, 255);
  var leftPanelColor = Color.fromARGB(255, 241, 188, 188);
  var titlePanelColor = Color.fromARGB(127, 255, 255, 255);
  var titleHeight = 40.0;

  delPageView(name) {
    memoryPageView.remove(name);
    memoryPageViewAction.remove(name);
    pageViewIndex =
        memoryPageView.isEmpty ? pageViewIndex : memoryPageView.keys.last;
  }

  setPageView(name) {
    pageViewIndex = name;
  }
}
