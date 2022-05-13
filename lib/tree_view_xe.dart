import 'package:flutter/material.dart';

import 'cfg.dart';

class TreeViewXe extends StatefulWidget {
  const TreeViewXe({Key? key}) : super(key: key);

  @override
  State<TreeViewXe> createState() => _TreeViewXeState();
}

class _TreeViewXeState extends State<TreeViewXe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: Column(children: [
        Cfg().title == '' ? Container() : Text(Cfg().title),
        Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.yellow,
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Row(
              children: [
                for (var i = 0;
                    i < Cfg().memoryLeafAction.values.toList().length;
                    i++)
                  Cfg().memoryLeafAction.values.toList()[i],
              ],
            )),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < Cfg().getLeafNode.length; i++)
                    TButton(Cfg().getLeafNode.keys.toList()[i],
                        Cfg().getLeafNode.values.toList()[i])
                ],
              ),
            ),
            Expanded(
                child:
                    Cfg().memoryLeafNode[Cfg().pageViewIndex] ?? Container()),
          ],
        )
      ]),
    );
  }

  TextButton TButton(String k, Widget pw1) {
    return TextButton(
        onPressed: () {
          Cfg().memoryLeafNode.putIfAbsent(k, () => pw1);
          Cfg().memoryLeafAction.putIfAbsent(
              k,
              () => Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: const Color.fromARGB(255, 138, 97, 97),
                            width: 1)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                            onPressed: () {
                              // actionList.removeWhere((key, value) => key == '2');
                              // controller.pageIndex = controller.pageIndex - 1;
                            },
                            child: Text(
                              k,
                              style: TextStyle(color: Colors.black87),
                            )),
                        IconButton(
                            onPressed: () {
                              Cfg().memoryLeafNode.remove(k);
                              Cfg().memoryLeafAction.remove(k);
                              Cfg().pageViewIndex = Cfg().memoryLeafNode.isEmpty
                                  ? Cfg().pageViewIndex
                                  : Cfg().memoryLeafNode.keys.last;
                              setState(() {});
                            },
                            icon: const Icon(Icons.close)),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ));
          Cfg().pageViewIndex = k;
          setState(() {});
        },
        child: Text('追加' + k));
  }
}
