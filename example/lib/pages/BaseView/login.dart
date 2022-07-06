import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../home.dart';

class Login extends StatefulWidget {
  @override
  _Example3State createState() => _Example3State();
}

class _Example3State extends State<Login> {
  var isLogin = false;
  var rocketBottom = -80.0;
  var rocketWidth = 160.0;
  var f = false;
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
    Future.delayed(Duration(seconds: 1), () {
      if (!f) {
        setState(() {
          rocketBottom = MediaQuery.of(context).size.height - 10;
          rocketWidth = 40.0;
          f = true;
        });
      }
    });

    return Scaffold(
      backgroundColor: co,
      // appBar: AppBar(),
      body: Center(
        child: FocusScope(
          node: node,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AnimatedPositioned(
                      child: Image.asset(
                        'assets/images/rocket.png',
                        fit: BoxFit.fitWidth,
                      ),
                      bottom: rocketBottom,
                      width: rocketWidth,
                      duration: Duration(seconds: 10),
                      curve: Curves.easeInCubic,
                    ),

                    ///约束
                    Container(
                      width: 800,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  autofocus: true,
                                  controller: controller1,
                                  cursorColor: Colors.orange,
                                  cursorWidth: 2,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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

                          Container(
                            height: 360,
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 420,
                              child: TextButton(
                                onPressed: () {
                                  if ((controller1.value.text == "") ||
                                      (controller2.value.text == "")) {
                                    node.nextFocus();
                                  } else {
                                    isLogin = true;
                                    setState(() {});
                                    Future(
                                      () {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          isLogin = false;
                                          Navigator.pushAndRemoveUntil<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const Home()),
                                            ModalRoute.withName('/'),
                                          );
                                          setState(() {});
                                        });
                                      },
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return const Color.fromARGB(
                                          255, 41, 103, 255);
                                    }
                                    return const Color.fromARGB(
                                        155, 41, 103, 255);
                                  }),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                  ),
                                ),
                                child: const Text('登录',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20)),
                              ),
                            ),
                          ),

                          if (isLogin) const CircularProgressIndicator()
                        ],
                      ),
                    ),
                    Positioned(
                        top: 70,
                        child: Container(
                          width: 300,
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Colors.transparent,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/feature-1.png'),
                                    fit: BoxFit.fill,
                                  ) // Icon(Icons.person),
                                  ),
                            ],
                          ),
                        )),
                  ],
                )),
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
