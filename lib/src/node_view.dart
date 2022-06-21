///视图
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'mgr.dart';
import 'node_data.dart';

class NodeView extends StatefulWidget {
  final bool isLeaf;

  ///选中的节点
  final bool isSelected;
  final double left;
  final Icon image;
  final String title;
  Color? textColor;
  Color? bgColor;
  final double textSize;
  OnItemTap itemOnTap1;
  NodeData node;

  NodeView(this.image, this.title, this.bgColor, this.itemOnTap1, this.node, {Key? key, this.isSelected = false, this.isLeaf = true, this.left = 0, this.textColor = Colors.grey, this.textSize = 16})
      : super(key: key);

  @override
  State<NodeView> createState() => _NodeDataState();
}

class _NodeDataState extends State<NodeView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(color: widget.bgColor, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50))),
            child:

                /// Material 关键点 响应 hoverColor
                Material(
                    child: ListTile(
              dense: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50)),
              ),
              title: Text(
                widget.title,
                style: TextStyle(
                  // body1 -> body2
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w400,
                  fontSize: widget.textSize,
                  letterSpacing: 0.2,
                  color: widget.textColor,
                ),
              ),
              trailing: widget.isLeaf ? null : widget.image,
              leading: widget.isLeaf ? widget.image : null,
              hoverColor: Colors.blue.withOpacity(0.8),
              enabled: true,
              onTap: () {
                widget.itemOnTap1(widget.node);
              },
            )

                    ///
                    ),

            ///
          ),
        ],
      ),
    );
  }
}
