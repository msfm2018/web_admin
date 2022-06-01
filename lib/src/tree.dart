import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'object_bean.dart';
import 'tree_node.dart';

typedef Wb<T> = Widget Function(T);

typedef OnItemTap = void Function(TreeNode<dynamic> node);

///树的管理者
class Trees extends State {
  Trees._() {
    _h = this;

    /// 配对数据
    corePageView = <String, Widget>{};
    corePageViewClassData = <String, dynamic>{};

    ///
    corePageViewAction = <String, Widget>{};
    treeStreamControl = StreamController<Trees>.broadcast();
  }

  static Trees? _h;
  factory Trees() {
    return _h ??= Trees._();
  }

  bool isAllExpanded = false;

  ///通知 重画树 画toolbar 的作用
  late StreamController<Trees> treeStreamControl;

  ///页面临时pageView
  late Map<String, Widget> corePageView;

  ///数据Persistence持久化
  late Map<String, dynamic> corePageViewClassData;

  ///内存节点快捷按钮
  late Map<String, Widget> corePageViewAction;

  /// 3个core 共用一个 key 保证关联
  String shareKey = '';

  var rightPanelColor = Colors.white;
  var toolbarColor = const Color(0xFFFEFEFE);
  var toolbarHeight = 40.0;

  Future<String> delPageView(name) async {
    print('删除' + name);
    corePageView.remove(name);
    corePageViewAction.remove(name);

    ///更新持久化数据 对象状态变化看上去flutter内存做了一些特殊处理 后面必须remove掉它 不然前端书写有可能报错 挺奇怪？
    corePageViewClassData.update(name, (value) {
      try {
        if ((value != null)) {
          if (value.destroy() != null) {
            value.destroy();
          }
        }
      } catch (_) {}
    });
    corePageViewClassData.remove(name);

    ///
    shareKey = corePageView.isEmpty ? shareKey : corePageView.keys.last;
    return shareKey;
  }

  savePageView(Wb b, node) {
    if (corePageView.containsKey((node.object as LeafNode).leafName)) {
    } else {
      try {
        //pageView
        corePageView.putIfAbsent((node.object as LeafNode).leafName, () => (node.object as LeafNode).object);
        //title button
        corePageViewAction.putIfAbsent((node.object as LeafNode).leafName, () => b(node));
      } catch (_) {}
    }

    ///持久化 memoryPageViewDataObject
    if (corePageViewClassData.containsKey((node.object as LeafNode).leafName)) {
      print('已经包容' + (node.object as LeafNode).leafName);
    } else {
      print('放入' + (node.object as LeafNode).leafName);
      corePageViewClassData.putIfAbsent((node.object as LeafNode).leafName, () => node.object.clas);
    }
  }

  notifyUi() {
    Trees().treeStreamControl.add(Trees());
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
    treeStreamControl.close();
    super.dispose();
  }
}
