import 'package:flutter/material.dart';
import 'package:myplus/myplus.dart';

import '../constans/constans.dart';
import '../pages/friend_circle.dart';
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

class P3Data implements DataBase {
  var myTitle = 'mytitile';
  int i = 0;

  ///
  @override
  void destroy() {
    myTitle = 'mytitile';
    i = 0;
  }
}

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
        LeafNode(P1('人脸检测'),
            leafName: "人脸检测",
            clas: P1Data(),
            leafSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.selectColor,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.unSelectColor,
            )),
        LeafNode(PMultipage(),
            leafName: "多页文档",
            leafSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.selectColor,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.unSelectColor,
            )),
        LeafNode(PPassword(),
            leafName: "密码强度提示",
            clas: P1Data(),
            leafSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.selectColor,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.unSelectColor,
            )),
        LeafNode(const PBarcode(),
            leafName: "生成二维码",
            clas: P1Data(),
            leafSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.selectColor,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.unSelectColor,
            )),
        LeafNode(const FriendCircle(data: friendCircleData),
            leafName: "朋友圈",
            clas: P1Data(),
            leafSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.selectColor,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.unSelectColor,
            )),
        LeafNode(const PMaps(),
            leafName: "地图",
            clas: P1Data(),
            leafSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.selectColor,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.unSelectColor,
            )),
        LeafNode(PSignaturePad(),
            leafName: "手写签名",
            clas: P1Data(),
            leafSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.selectColor,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.abc,
              color: AppConstans.unSelectColor,
            )),
      ],

      ///
      "部门管理",
      dirSelectedIcon: const Icon(
        Icons.device_hub,
        color: Colors.yellow,
      ),
      dirUnSelectedIcon: const Icon(
        Icons.device_hub,
        color: Colors.red,
      )),
];

///定义根目录
var rootNode = [
  DirectoryNode(
      [
        ...twoNode
      ],

      ///定义叶节点
      [
        ///叶节点
        LeafNode(const PDataGrid1(),
            leafName: "数据管理",
            leafSelectedIcon: const Icon(
              Icons.read_more,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.read_more_outlined,
            )),

        ///叶节点
        LeafNode(PChart(),
            leafName: "图表",
            leafSelectedIcon: const Icon(
              Icons.trending_up,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.trending_up,
            )),

        ///叶节点
        LeafNode(const CreatePdfWidget(),
            leafName: "生成PDF文件",
            leafSelectedIcon: const Icon(
              Icons.functions,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.functions,
            )),

        ///
        LeafNode(const PdfView(),
            leafName: "PDF查看",
            leafSelectedIcon: const Icon(
              Icons.functions,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.functions,
            )),

        ///
        LeafNode(
          const P2(),
          leafName: "用户管理",
        ),

        ///
        LeafNode(P3('角色管理'),
            leafName: "角色管理",
            clas: P3Data(),
            leafSelectedIcon: const Icon(
              Icons.abc,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.abc,
            )),

        ///持久化数据
        LeafNode(P4(K4),
            leafName: K4,
            clas: P4Data(),
            leafSelectedIcon: const Icon(
              Icons.abc,
            ),
            leafUnSelectedIcon: const Icon(
              Icons.abc,
            )),
      ],

      ///定义目录信息
      "首 页",
      dirSelectedIcon: const Icon(Icons.device_hub, color: Colors.yellow),
      dirUnSelectedIcon: const Icon(
        Icons.device_hub,
        color: Colors.red,
      )

      ///
      ),
];
