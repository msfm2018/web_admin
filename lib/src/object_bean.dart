import 'package:flutter/material.dart';

class Node {
  List<Node> data;
  List<LeafNode> leafs;
  String name;
  Node(this.data, this.leafs, this.name);
}

class LeafNode<T> {
  String btnCaption;
  Widget object;
  T? clas;
  LeafNode(this.object, {required this.btnCaption, this.clas});
}
