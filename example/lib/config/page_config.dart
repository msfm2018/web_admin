import 'package:flutter/material.dart';
import 'package:myplus/myplus.dart';

import '../component/keep_alive_wrapper.dart';
import '../pages/friend_circle.dart';
import '../pages/im/mainpage.dart';
import '../pages/p_aa1.dart';
import '../pages/p_keep_live.dart';
import '../pages/p_map.dart';
import '../pages/p_multipage.dart';
import '../pages/p_password.dart';
import '../pages/p_barcode.dart';
import '../pages/p_chart.dart';
import '../pages/p_datagrid1.dart';
import '../pages/p_1.dart';
import '../pages/p_2.dart';
import '../pages/p_3.dart';
import '../pages/p_4.dart';
import '../pages/p_user.dart';
import '../pages/pdf/my_pdf.dart';
import '../pages/pdf_view.dart';
import '../pages/p_signature_pad.dart';

const K4 = '工具存储';

class P4Data implements DataBase {
  var a = 'abc';
  var testint = 0;
  var editText = '解锁新技能';
  @override
  void destroy() {
    a = 'abc';
    testint = 0;
    editText = '解锁新技能';
  }
}

// class P3Data implements DataBase {
//   var myTitle = 'mytitile';
//   int i = 0;

//   /// 数据还原
//   @override
//   void destroy() {
//     myTitle = 'mytitile';
//     i = 0;
//   }
// }

class P1Data {
  @override
  noSuchMethod(Invocation invocation) {
    print('缺少clear方法');
  }
}

///以上定义持久化数据
///定义二级目录
var twoNode = [
  DirectoryNode(
    ///下级目录
    [],

    ///定义子节点
    [
      LeafNode(
        const SAreaAgeGenderMain(),
        name: "tabView",
      ),

      LeafNode(
        P1('人脸检测'),
        name: "人脸检测",
        viewData: P1Data(),
      ),

      LeafNode(
          PXX(
            key: PageStorageKey<String>("key_Page1"),
          ),
          name: "PXX"),
      LeafNode(
        const Mydata(),
        name: "用户数据",
      ),

      ///
      LeafNode(
        const PMultipage(),
        name: "多页文档",
      ),

      ///
      LeafNode(
        PPassword(),
        name: "密码强度提示",
        viewData: P1Data(),
      ),

      ///
      LeafNode(
        const PBarcode(),
        name: "生成二维码",
        viewData: P1Data(),
      ),

      ///
      LeafNode(
        const FriendCircle(data: friendCircleData),
        name: "朋友圈",
        viewData: P1Data(),
      ),

      ///
      LeafNode(
        const PMaps(),
        name: "地图",
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
    "部门管理",
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
        const PDataGrid1(),
        name: "数据管理",
      ),

      ///叶节点
      LeafNode(
        PChart(),
        name: "图表",
      ),

      ///
      LeafNode(
        const CodeBookHomePage(),
        name: "IM",
      ),

      ///叶节点
      LeafNode(
        const CreatePdfWidget(),
        name: "生成PDF文件",
      ),

      ///
      LeafNode(
        const PdfView(),
        name: "PDF查看",
      ),

      ///
      LeafNode(
        const P2(),
        name: "用户管理",
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

    ///定义目录信息
    "首 页",
  ),
];
