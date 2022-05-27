import 'package:flutter/material.dart';

import '../constans/app_constants.dart';
import 'home.dart';

FocusNode userFocusNode = FocusNode();
FocusNode passFocusNode = FocusNode();

class PLogin extends StatefulWidget {
  const PLogin({Key? key}) : super(key: key);

  @override
  _PLoginState createState() => _PLoginState();
}

class _PLoginState extends State<PLogin> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _isObscure = true;
  Color _eyeColor = Colors.black;
  final List _loginMethod = [
    {
      "title": "facebook",
      "icon": Icons.facebook,
    },
    {
      "title": "google",
      "icon": Icons.facebook,
    },
    {
      "title": "twitter",
      "icon": Icons.facebook,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                const SizedBox(
                  height: kToolbarHeight,
                ),
                buildTitle(),
                buildTitleLine(),
                const SizedBox(height: 70.0),
                buildEmailTextField(),
                const SizedBox(height: 30.0),
                buildPasswordTextField(context),
                buildForgetPasswordText(context),
                const SizedBox(height: 60.0),
                buildLoginButton(context),
                const SizedBox(height: 30.0),
                buildOtherLoginText(),
                buildOtherMethod(context),
                buildRegisterText(context),
              ],
            )));
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('没有账号？'),
            GestureDetector(
              child: const Text(
                '点击注册',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                print('去注册');
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
                builder: (context) {
                  return IconButton(
                      icon: Icon(item['icon'], color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        //TODO : 第三方登录方法
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("${item['title']}登录"),
                          action: SnackBarAction(
                            label: "取消",
                            onPressed: () {},
                          ),
                        ));
                      });
                },
              ))
          .toList(),
    );
  }

  Align buildOtherLoginText() {
    return const Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState!.save();
              //TODO 执行登录方法
              print('email:$_email , assword:$_password');
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MyHomePage();
              }));
            }
          },
          child: const Text(
            '登录',
            style: TextStyle(color: AppConstans.btTextColor),
          ),
        ),
      ),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (value) => _password = value!,
      obscureText: _isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          return '请输入密码';
        }
      },
      focusNode: passFocusNode,
      decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: passFocusNode.hasFocus ? Colors.blue : Colors.black),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = (_isObscure ? Colors.grey : Theme.of(context).iconTheme.color)!;
                });
              })),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      focusNode: userFocusNode,
      decoration: InputDecoration(labelText: 'Account', labelStyle: TextStyle(color: userFocusNode.hasFocus ? Colors.blue : Colors.black)),
      // validator: (value) {
      //   var emailReg = RegExp(
      //       r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
      //   if (!emailReg.hasMatch(value!)) {
      //     return '请输入正确的邮箱地址';
      //   }
      // },
      onSaved: (value) => _email = value!,
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
}
