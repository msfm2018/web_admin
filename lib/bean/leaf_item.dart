import 'package:flutter/material.dart';

class LeafItem extends StatelessWidget {
  final double left;
  final String image;
  final String title;
  final Color textColor;
  final double textSize;

  LeafItem(this.image, this.title,
      {this.left = 0, this.textColor = Colors.black, this.textSize = 18});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(left, 0, 10, 0),
                    child: Image.asset(
                      image,
                      width: 20,
                      height: 20,
                    )),
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
