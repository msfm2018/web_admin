import 'package:flutter/material.dart';

class DirectoryNode {
  ///下级目录节点列表
  List<DirectoryNode> childDirectoryNodes;

  ///叶节点
  List<LeafNode> leafs;

  ///目录节点名称
  String name;

  ///目录展开图标
  Icon? dirSelectedIcon;

  ///目录折叠图标
  Icon? dirUnSelectedIcon;

  DirectoryNode(this.childDirectoryNodes, this.leafs, this.name,
      {this.dirSelectedIcon, this.dirUnSelectedIcon});
}

class LeafNode<T> {
  ///叶节点名称
  String leafName;

  /// Widget ;
  T object;

  ///Widget 数据
  T? clas;

  ///叶节点选中图标
  Icon? leafSelectedIcon;

  ///叶节点未选中图标
  Icon? leafUnSelectedIcon;

  ///this.object Widget
  LeafNode(this.object,
      {required this.leafName,
      this.clas,
      this.leafSelectedIcon,
      this.leafUnSelectedIcon});
}
