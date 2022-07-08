import 'package:flutter/material.dart';
import 'package:myplus/myplus.dart';

import '../view/friend_circle.dart';
import '../view/im/mainpage.dart';
import '../view/p_indexstack.dart';
import '../view/p_paginated.dart';
import '../view/p_keep_live.dart';
import '../view/p_multipage.dart';
import '../view/p_barcode.dart';
import '../view/p_chart.dart';
import '../view/p_1.dart';
import '../view/p_2.dart';
import '../view/p_3.dart';
import '../view/p_4.dart';
import '../view/p_signature_pad.dart';

var Three = [
  DirectoryNode(
    ///下级目录
    [],

    ///定义子节点
    [
      LeafNode(
        TestIndexStack(),
        name: "测试indexstack",
      ),
      LeafNode(
        const SAreaAgeGenderMain(),
        name: "tabView",
      ),
      LeafNode(
        const P1(),
        name: "列表滚动位置固定",
        viewData: P1Data(),
      ),

      ///系统方法 数据持久化
      LeafNode(
        P3('系统方法', key: const PageStorageKey<String>("p3")),
        name: "系统方法",
      ),

      ///框架自带方法 数据持久化
      LeafNode(
        P4('框架方法'),
        name: '框架方法',
        viewData: P4Data(),
      ),
    ],

    ///
    "各种状态保存相关",
  ),
];

///定义二级目录
var twoNode = [
  DirectoryNode(
    ///下级目录
    [...Three],

    ///定义子节点
    [
      LeafNode(const Paginated(), name: "分页数据管理"),
// IndexedStack， tabview也可以结合它 保持页面状态
//对于数据： with SingleTickerProviderStateMixin（一般tabview使用 保持页面状态）  PageStorageKey(ListView使用比较好)
// PageStorage.of 官方页面数据存储   自己可以做memory管理
      ///
      LeafNode(
        const PMultipage(),
        name: "多页文档",
      ),

      ///
      LeafNode(
        const PBarcode(),
        name: "生成二维码",
      ),

      ///
      LeafNode(
        const FriendCircle(data: friendCircleData),
        name: "朋友圈",
        viewData: P1Data(),
      ),

      ///
      LeafNode(
        PSignaturePad(),
        name: "手写签名",
        viewData: P1Data(),
      ),
    ],

    ///
    "os开发",
  ),
];

///定义根目录
var rootNode = [
  DirectoryNode(
    [...twoNode],

    ///定义叶节点
    [
      ///叶节点
      LeafNode(
        PChart(),
        name: "图表",
      ),

      ///
      LeafNode(
        const CodeBookHomePage(),
        name: "IMDemo",
      ),

      ///
      LeafNode(
        const P2(),
        name: "头像处理",
      ),
    ],

    ///定义目录信息
    "核心科研",
  ),
];
