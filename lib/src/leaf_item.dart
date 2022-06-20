import 'package:flutter/material.dart';

import 'mgr.dart';
import 'tree_node.dart';

class LeafItem extends StatefulWidget {
  final double left;
  final Icon image;
  final String title;
  Color? textColor;
  Color? bgColor;
  final double textSize;
  OnItemTap itemOnTap1;
  TreeNode node;

  LeafItem(this.image, this.title, this.bgColor, this.itemOnTap1, this.node, {Key? key, this.left = 0, this.textColor = Colors.grey, this.textSize = 16}) : super(key: key);

  @override
  State<LeafItem> createState() => _LeafItemState();
}

class _LeafItemState extends State<LeafItem> {
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
                  color: const Color(0xFF253840),
                ),

                // TextStyle(
                //   fontSize: widget.textSize,
                //   fontWeight: FontWeight.w100,
                // ),
              ),
              leading: widget.image,
              // trailing: Icon(Icons.keyboard_arrow_right),
              // leading: CircleAvatar(backgroundImage: NetworkImage('https://lupic.cdn.bcebos.com/20210629/3000001317_14.jpg')),
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
          // ),
        ],
      ),
      // )
    );
  }
}
