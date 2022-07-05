import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../home.dart';

class Login extends StatefulWidget {
  @override
  _Example3State createState() => _Example3State();
}

class _Example3State extends State<Login> {
  var isLogin = false;

  FocusScopeNode node = FocusScopeNode();

  ///

  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    //  WidgetsBinding.instance.addPostFrameCallback((_) => );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.linearToSrgbGamma(),
                    image: AssetImage('assets/images/bg.jpg')

                    ///
                    )),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: jmpScaffold(context, Colors.transparent))));
  }

  Scaffold jmpScaffold(BuildContext context, Color? co) {
    return Scaffold(
      backgroundColor: co,
      // appBar: AppBar(),
      body: FocusScope(
        node: node,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        // style: TextStyle(
                        //   fontSize: 13,
                        //   fontWeight: FontWeight.bold,
                        //   color: Color(0xFF999999),
                        // ),
                        autofocus: true,
                        controller: controller1,
                        cursorColor: Colors.orange,
                        cursorWidth: 2,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          // icon: Icon(Icons.person),
                          hintText: '请输入账号',
                          suffixIcon: IconButton(
                            ///跳过焦点
                            focusNode: FocusNode(skipTraversal: true),
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              controller1.clear();
                            },
                          ),
                        ),
                        onEditingComplete: onEdit,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        // focusNode: userFocusNode2,
                        controller: controller2,
                        // decoration:null 无边框
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: '请输入密码',
                          suffixIcon: IconButton(
                            focusNode: FocusNode(skipTraversal: true),
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              controller2.clear();
                            },
                          ),
                        ),
                        maxLength: 8,
                        cursorColor: Colors.orange,
                        cursorWidth: 2,
                        obscureText: true,
                        onEditingComplete: onEdit,
                      ),
                    ),
                  ],
                ), //Future.microtask
                RaisedButton(
                  focusColor: Colors.orange,
                  onPressed: () {
                    if ((controller1.value.text == "") ||
                        (controller2.value.text == "")) {
                      node.nextFocus();
                    } else {
                      isLogin = true;
                      setState(() {});
                      Future(
                        () {
                          Future.delayed(const Duration(seconds: 1), () {
                            isLogin = false;
                            Navigator.pushAndRemoveUntil<void>(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Home()),
                              ModalRoute.withName('/'),
                            );
                            setState(() {});
                          });
                        },
                      );
                    }
                  },
                  // focusNode: FocusNode(skipTraversal: true),
                  child: const Text('登录'),
                ),
                if (isLogin) const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onEdit() {
    node.nextFocus();
  }

  @override
  void dispose() {
    super.dispose();
    node.dispose();
  }
}
