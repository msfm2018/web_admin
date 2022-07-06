import 'package:flutter/material.dart';

class User {
  User(this.name, this.age, this.sex);

  final String name;
  final int age;
  final String sex;
}

class Mydata extends StatefulWidget {
  const Mydata({Key? key}) : super(key: key);

  @override
  State<Mydata> createState() => _MydataState();
}

class _MydataState extends State<Mydata> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100,

        /// PageStorageKey 数据 状态不变化
        key: const PageStorageKey<String>('page'),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {},
            title: const Text('hello'),
            subtitle: Text('subtitle{$index}'),
          );
        });
  }
}
