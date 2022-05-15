import 'package:flutter/material.dart';

class P1 extends StatelessWidget {
  const P1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: 100, // item 的个数
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0, color: Colors.blue), // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("title $index"), // item 标题
          leading: Icon(Icons.keyboard), // item 前置图标
          subtitle: Text("subtitle $index"), // item 副标题
          trailing: Icon(Icons.keyboard_arrow_right), // item 后置图标
          isThreeLine: false, // item 是否三行显示
          dense: true, // item 直观感受是整体大小
          contentPadding: EdgeInsets.all(10.0), // item 内容内边距
          enabled: true,
          onTap: () {
            print('点击:$index');
          }, // item onTap 点击事件
          onLongPress: () {
            print('长按:$index');
          }, // item onLongPress 长按事件
          selected: false, // item 是否选中状态
        );
      },
    );
  }
}
