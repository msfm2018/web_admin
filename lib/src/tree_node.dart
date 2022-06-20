import 'package:flutter/material.dart';

import 'mgr.dart';
import 'object_bean.dart';

enum NodeState { nsExpanded, nsSelected, nsFocused }

class TreeNode<T> {
  bool isExpanded;
  int depth;
  bool isLeaf;
  int nodeId;
  int fatherId;

  ///leaf图标
  Icon? leafIcon;

  ///目录折叠图标
  Icon? directoryUnSelectedIcon;

  ///目录展开图标
  Icon? directorySelectedIcon;

  ///目录节点 还是Widget leaf节点
  T object;
  int selectedIndex;

  TreeNode(
    this.depth,
    this.isLeaf,
    this.nodeId,
    this.fatherId,
    this.object, {
    this.leafIcon,
    this.directoryUnSelectedIcon,
    this.directorySelectedIcon,
    this.isExpanded = false,
    this.selectedIndex = -1,
  });
}

class TreeNodes {
  ///所有数据
  late List<TreeNode> treeNodes;

  ///展开数据
  late List<TreeNode> expandNodes;
  int nodeId = 1;
  TreeNodes._() {
    treeNodes = [];
    expandNodes = [];
    _h = this;
  }
  static TreeNodes? _h;
  factory TreeNodes() {
    return _h ??= TreeNodes._();
  }

  void expand(int id) {
    List<TreeNode> tmp = [];
    for (TreeNode node in treeNodes) {
      if (node.fatherId == id) {
        tmp.add(node);
      }
    }
    //找到插入点
    int index = -1;
    int length = expandNodes.length;
    for (int i = 0; i < length; i++) {
      if (id == expandNodes[i].nodeId) {
        index = i + 1;
        break;
      }
    }
    index = index == -1 ? 0 : index;
    expandNodes.insertAll(index, tmp);
  }

  void expandAll() {
    expandNodes.insertAll(0, treeNodes);
  }

  void collapse(int id) {
    var _dirtyNodes = <int>[];
    void _markDirty(int id) {
      for (TreeNode node in expandNodes) {
        if (id == node.fatherId) {
          if (!node.isLeaf) {
            _markDirty(node.nodeId);
          }
          _dirtyNodes.add(node.nodeId);
        }
      }
    }

    _dirtyNodes.clear();
    _markDirty(id);
    List<TreeNode> tmp = [];
    for (TreeNode node in expandNodes) {
      if (!_dirtyNodes.contains(node.nodeId)) {
        tmp.add(node);
      } else {
        node.isExpanded = false;
      }
    }
    expandNodes.clear();
    expandNodes.addAll(tmp);
  }

  void init() {
    for (TreeNode node in treeNodes) {
      if (node.fatherId == -1) {
        expandNodes.add(node);
      }
    }
  }

  void dataParses(List<DirectoryNode> nodes) {
    for (DirectoryNode dir in nodes) {
      dataParse(dir);
    }
  }

  void dataParse(DirectoryNode dir, {int depth = 0, int fatherId = -1}) {
    int currentId = nodeId;
    if (Mgr().isAllExpanded) {
      treeNodes.add(TreeNode(depth, false, nodeId++, fatherId, dir, isExpanded: true, directorySelectedIcon: dir.selectedIcon, directoryUnSelectedIcon: dir.unSelectedIcon));
    } else {
      treeNodes.add(TreeNode(depth, false, nodeId++, fatherId, dir, directorySelectedIcon: dir.selectedIcon, directoryUnSelectedIcon: dir.unSelectedIcon));
    }

    for (LeafNode leaf in dir.leafs) {
      treeNodes.add(TreeNode(depth + 1, true, nodeId++, currentId, leaf));
    }

    for (DirectoryNode dr in dir.childDirectoryNodes) {
      dataParse(dr, depth: depth + 1, fatherId: currentId);
    }
  }
}
