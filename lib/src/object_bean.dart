import 'package:flutter/material.dart';

///数据节点
class DirectoryNode {
  ///下级目录节点列表
  List<DirectoryNode> childDirectoryNodes;

  ///叶节点
  List<LeafNode> leafs;

  ///目录节点名称
  String name;

  ///目录展开图标
  Icon? selectedIcon;

  ///目录折叠图标
  Icon? unSelectedIcon;

  DirectoryNode(this.childDirectoryNodes, this.leafs, this.name, {this.selectedIcon, this.unSelectedIcon});
}

class LeafNode<T> {
  ///叶节点名称
  String name;

  /// Widget ;
  T object;

  ///Widget 数据
  T? clas;

  ///叶节点选中图标
  Icon? selectedIcon;

  ///叶节点未选中图标
  Icon? unSelectedIcon;

  ///this.object Widget
  LeafNode(this.object, {required this.name, this.clas, this.selectedIcon, this.unSelectedIcon});
}
