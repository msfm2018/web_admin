import 'ObjectBean.dart';

enum NodeState { nsExpanded, nsSelected, nsFocused }

class TreeNode<T> {
  bool expand;
  int depth;
  bool isLeaf;
  int nodeId;
  int fatherId;

  ///父节点 还是leaf节点
  T object;
  int selectedIndex;

  TreeNode(
    this.expand,
    this.depth,
    this.isLeaf,
    this.nodeId,
    this.fatherId,
    this.object, {
    this.selectedIndex = -1,
  });
}

class TreeNodes {
  ///所有数据
  late List<TreeNode> items;

  ///展开数据
  late List<TreeNode> expandItem;
  late List<int> dirtyItem;
  int nodeId = 1;
  TreeNodes._() {
    items = [];
    expandItem = [];
    dirtyItem = [];
    _h = this;
  }
  static TreeNodes? _h;
  factory TreeNodes() {
    return _h ??= TreeNodes._();
  }

  void expand(int id) {
    List<TreeNode> tmp = [];
    for (TreeNode node in items) {
      if (node.fatherId == id) {
        tmp.add(node);
      }
    }
    //找到插入点
    int index = -1;
    int length = expandItem.length;
    for (int i = 0; i < length; i++) {
      if (id == expandItem[i].nodeId) {
        index = i + 1;
        break;
      }
    }
    index = index == -1 ? 0 : index;
    expandItem.insertAll(index, tmp);
  }

  void collapse(int id) {
    void _markDirty(int id) {
      for (TreeNode node in expandItem) {
        if (id == node.fatherId) {
          if (!node.isLeaf) {
            _markDirty(node.nodeId);
          }
          dirtyItem.add(node.nodeId);
        }
      }
    }

    dirtyItem.clear();
    _markDirty(id);
    List<TreeNode> tmp = [];
    for (TreeNode node in expandItem) {
      if (!dirtyItem.contains(node.nodeId)) {
        tmp.add(node);
      } else {
        node.expand = false;
      }
    }
    expandItem.clear();
    expandItem.addAll(tmp);
  }

  void init() {
    for (TreeNode node in items) {
      if (node.fatherId == -1) {
        expandItem.add(node);
      }
    }
  }

  void dataParses(List<Node> nodes) {
    for (Node node in nodes) {
      dataParse(node);
    }
  }

  void dataParse(Node node, {int depth = 0, int fatherId = -1}) {
    int currentId = nodeId;
    items.add(TreeNode(false, depth, false, nodeId++, fatherId, node));

    for (LeafNode leaf in node.leafs) {
      items.add(TreeNode(false, depth + 1, true, nodeId++, currentId, leaf));
    }

    for (Node nd in node.data) {
      dataParse(nd, depth: depth + 1, fatherId: currentId);
    }
  }
}
