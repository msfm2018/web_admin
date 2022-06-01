import 'package:flutter/material.dart';

import 'tree.dart';
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
    return
        //  MouseRegion(
        //     onEnter: (event) {
        //       widget.bgColor = Colors.amberAccent;
        //     },
        //     child:
        SizedBox(
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(color: widget.bgColor, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50))),
            // padding: const EdgeInsets.all(8),
            child:

                /// Material 关键点 响应 hoverColor
                Material(
                    child:

                        ///
                        ListTile(
              dense: true,
              shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(50),
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50)),
                // side: BorderSide(color: Colors.black),
              ),
              title: Text(
                widget.title,
                style: TextStyle(
                  // body1 -> body2
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w400,
                  fontSize: widget.textSize,
                  letterSpacing: 0.2,
                  color: Color(0xFF253840),
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

          // Container(
          //   decoration: BoxDecoration(
          //     border: Border(
          //       bottom: BorderSide(
          //         color: Colors.grey[800]!,
          //         width: 2.0,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      // )
    );
  }
}

// class LeafItem extends StatelessWidget {
//   final double left;
//   final Icon image;
//   final String title;
//   final Color textColor;
//   final double textSize;

//   const LeafItem(this.image, this.title, {Key? key, this.left = 0, this.textColor = Colors.black, this.textSize = 18}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Color _color=Colors.black;
//     return SizedBox(
//       width: 200,
//       child: Column(
//         children: <Widget>[
//           MouseRegion(
//               onEnter: (event) {
//                 print("onEnter---$event");
//                 setState(() {
//                   _color = Colors.black;
//                 });
//               },
//               onExit: (event) {
//                 print("onExit---$event");
//                 setState(() {
//                   _color = Colors.yellow;
//                 });
//               },
//               onHover: (event) {
//                 // print("onHover---$event");
//                 setState(() {
//                   _color = Colors.white;
//                 });
//               },
//               // cursor: MouseCursor.uncontrolled,
//               cursor: SystemMouseCursors.click,
//               opaque: false,
//               child: Container(
//                 color: _color,
//                 padding: const EdgeInsets.all(8),
//                 child: Row(
//                   children: <Widget>[
//                     Padding(padding: EdgeInsets.fromLTRB(left, 0, 10, 0), child: image),
//                     Expanded(
//                         child: Text(
//                       title,
//                       style: TextStyle(
//                         color: textColor,
//                         fontSize: textSize,
//                       ),
//                     )),
//                   ],
//                 ),
//               )),
//           Container(
//             color: Colors.black38,
//             height: 0.5,
//           ),
//         ],
//       ),
//     );
//   }
// }
