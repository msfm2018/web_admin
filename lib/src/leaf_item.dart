import 'package:flutter/material.dart';

class LeafItem extends StatefulWidget {
  final double left;
  final Icon image;
  final String title;
  Color? textColor;
  Color? bgColor;
  final double textSize;

  LeafItem(this.image, this.title, this.bgColor, {Key? key, this.left = 0, this.textColor = Colors.grey, this.textSize = 18}) : super(key: key);

  @override
  State<LeafItem> createState() => _LeafItemState();
}

class _LeafItemState extends State<LeafItem> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (event) {
          widget.bgColor = Colors.amberAccent;
        },
        child: SizedBox(
          width: 200,
          child: Column(
            children: <Widget>[
              Container(
                // color: widget.textColor,
                decoration: BoxDecoration(color: widget.bgColor, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50))),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(widget.left, 0, 10, 0), child: widget.image),
                    Expanded(
                        child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white, // widget.textColor,
                        fontSize: widget.textSize,
                      ),
                    )),
                  ],
                ),
              ),
              // ),
              Container(
                color: Colors.transparent,
                height: 10.5,
              ),
            ],
          ),
        ));
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
