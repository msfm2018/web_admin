///控制器
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'entity.dart';
import 'node_data.dart';

typedef Wb<T> = Widget Function(T);

typedef OnItemTap = void Function(NodeData<dynamic> node);

extension GetResetExt on Map {
  void onDisposeKey(String key, Map<String, dynamic> map) {
    map.forEach((key1, value) {
      if (key1 == key) {
        value?.destroy();
      }
    });
  }
}

dynamic m(String key) {
  return Mgr().getData[key];
}

///树的管理者
class Mgr extends State {
  Mgr._() {
    _instance = this;

    /// 配对数据
    vView = <String, Widget>{};
    _vViewData = <String, dynamic>{};
    vViewAction = <String, Widget>{};

    ///
    _controler = StreamController.broadcast();
    ratioControler = StreamController.broadcast();
  }

  static Mgr? _instance;
  factory Mgr() {
    return _instance ??= Mgr._();
  }

  static Mgr get instance => _getInstance();

  static Mgr _getInstance() {
    return _instance ?? Mgr._();
  }

  ///整个数据
  List<LeafNode> leafNodes = [];

  bool isAllExpanded = false;

  ///树宽度比
  num ratio = 1 / 8;
  late StreamController<num> ratioControler;

  ///通知 重画树 画toolbar 的作用
  late StreamController<Mgr> _controler;
  get outer => _controler.stream;
///////////////////////////////////////////////////

  ///页面临时pageView
  late Map<String, Widget> vView;

  ///数据Persistence持久化
  late Map<String, dynamic> _vViewData; //SplayTreeMap LinkedHashMap hashMap
  get getData => _vViewData;

  ///内存节点快捷按钮
  late Map<String, Widget> vViewAction;
  // final HashMap<String, StreamBuild> dataBus = HashMap();
  /// 3个WidgetObj 共用一个 key 保证关联
  String shareKey = '';

///////////////////////////////////////////////////////
  var rightPanelColor = Colors.white;
  var toolbarColor = const Color(0xFFFEFEFE);
  var toolbarHeight = 40.0;

  Future<String> delPage(name) async {
    print('删除' + name);
    vView.remove(name);
    vViewAction.remove(name);

    for (var key in vView.keys) {
      print('————————————————————:::::' + key);
    }

    ///更新持久化数据 对象状态变化看上去flutter内存做了一些特殊处理 后面必须remove掉它 不然前端书写有可能报错 挺奇怪？
    ///清除对象数据
    _vViewData.onDisposeKey(name, _vViewData);
    _vViewData.remove(name);

    ///
    shareKey = vView.isEmpty ? shareKey : vView.keys.last;
    return shareKey;
  }

  savePage(Wb b, node) {
    // for (var key in corePageView.keys) {
    //   print('corePageView:::::' + key);
    // }

    if (vView.containsKey((node.object as LeafNode).name)) {
    } else {
      try {
        //pageView
        vView.putIfAbsent((node.object as LeafNode).name,
            () => (node.object as LeafNode).object);
        //title button
        vViewAction.putIfAbsent((node.object as LeafNode).name, () => b(node));
      } catch (_) {}
    }

    ///持久化 memoryPageViewDataObject
    if (_vViewData.containsKey((node.object as LeafNode).name)) {
      // print('已经包容' + (node.object as LeafNode).name);
    } else {
      // print('放入' + (node.object as LeafNode).name);
      _vViewData.putIfAbsent(
          (node.object as LeafNode).name, () => node.object.clas);
    }

    for (var key in vView.keys) {
      print('corePageView:::::' + key);
    }
  }

  notifyUi() {
    Mgr()._controler.add(Mgr());
  }

  String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  @override
  Widget build(Object context) {
    return Container();
  }

  @override
  void dispose() {
    _controler.close();
    super.dispose();
  }
}
