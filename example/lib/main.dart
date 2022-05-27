import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myplus/myplus.dart';

import 'constans/app_constants.dart';
import 'pages/p_login.dart';

Future<void> main() async {
  /// 确保初始化
  WidgetsFlutterBinding.ensureInitialized();

  // /// 自定义报错页面
  // ErrorWidget.builder = (FlutterErrorDetails details) {
  //   debugPrint(details.toString());
  //   return const Material();
  // };
  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const title = 'flutter企业级管理框架';
  @override
  Widget build(BuildContext context) {
    Cfg().allExpand = true;
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppConstans.bgColor,
        hintColor: Colors.grey.withOpacity(0.3),
        splashColor: Colors.transparent,
        canvasColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const PLogin(),
      },
    );
  }
}
