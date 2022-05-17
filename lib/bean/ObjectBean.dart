import 'package:flutter/material.dart';

class Node {
  List<Node> data;
  List<LeafNode> leafs;
  String name;
  Node(this.data, this.leafs, this.name);
}

class LeafNode {
  String name;
  Widget object;
  LeafNode(this.name, this.object);
}
