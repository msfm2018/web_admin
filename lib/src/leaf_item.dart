import 'package:flutter/material.dart';

class LeafItem extends StatelessWidget {
  final double left;
  final Icon image;
  final String title;
  final Color textColor;
  final double textSize;

  const LeafItem(this.image, this.title,
      {Key? key,
      this.left = 0,
      this.textColor = Colors.black,
      this.textSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(left, 0, 10, 0), child: image
                    //  Icon(
                    //   Icons.abc,
                    //   size: 20,
                    // )

                    //  Image.asset(
                    //   image,
                    //   width: 20,
                    //   height: 20,
                    // )

                    ),
                Expanded(
                    child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                  ),
                )),
              ],
            ),
          ),
          Container(
            color: Colors.black38,
            height: 0.5,
          ),
        ],
      ),
    );
  }
}
