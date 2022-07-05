///模型   mvc
import 'package:flutter/material.dart';

import 'mgr.dart';
import 'entity.dart';

enum NodeState { nsExpanded, nsSelected, nsFocused }

class NodeData<T> {
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

  NodeData(
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

class NodesDatas {
  ///所有数据
  late List<NodeData> treeNodes;

  ///展开数据
  late List<NodeData> expandNodes;
  int nodeId = 1;
  NodesDatas._() {
    treeNodes = [];
    expandNodes = [];
    _h = this;
  }
  static NodesDatas? _h;
  factory NodesDatas() {
    return _h ??= NodesDatas._();
  }

  void expand(int id) {
    List<NodeData> tmp = [];
    for (NodeData node in treeNodes) {
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
    var dirtyNodes = <int>[];
    void _markDirty(int id) {
      for (NodeData node in expandNodes) {
        if (id == node.fatherId) {
          if (!node.isLeaf) {
            _markDirty(node.nodeId);
          }
          dirtyNodes.add(node.nodeId);
        }
      }
    }

    dirtyNodes.clear();
    _markDirty(id);
    List<NodeData> tmp = [];
    for (NodeData node in expandNodes) {
      if (!dirtyNodes.contains(node.nodeId)) {
        tmp.add(node);
      } else {
        node.isExpanded = false;
      }
    }
    expandNodes.clear();
    expandNodes.addAll(tmp);
  }

  void init() {
    for (NodeData node in treeNodes) {
      if (node.fatherId == -1) {
        expandNodes.add(node);
      }
    }
  }

  void loadData(List<DirectoryNode> nodes) {
    for (DirectoryNode dir in nodes) {
      dataParse(dir);
    }
  }

  void dataParse(DirectoryNode dir, {int depth = 0, int fatherId = -1}) {
    int currentId = nodeId;
    if (Mgr().isAllExpanded) {
      treeNodes.add(NodeData(depth, false, nodeId++, fatherId, dir,
          isExpanded: true,
          directorySelectedIcon: dir.selectedIcon,
          directoryUnSelectedIcon: dir.unSelectedIcon));
    } else {
      treeNodes.add(NodeData(depth, false, nodeId++, fatherId, dir,
          directorySelectedIcon: dir.selectedIcon,
          directoryUnSelectedIcon: dir.unSelectedIcon));
    }

    for (LeafNode leaf in dir.leafs) {
      treeNodes.add(NodeData(depth + 1, true, nodeId++, currentId, leaf));
      Mgr().leafNodes.add(leaf);
    }

    for (DirectoryNode dr in dir.childDirectoryNodes) {
      dataParse(dr, depth: depth + 1, fatherId: currentId);
    }
  }
}
