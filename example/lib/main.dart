import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mtest/home.dart';
import 'package:myplus/myplus.dart';

import 'constans/constans.dart';
import 'pages/BaseView/login.dart';

Future<void> main() async {
  /// 确保初始化
  WidgetsFlutterBinding.ensureInitialized();

  /// 自定义报错提示
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    return const Material(
      child: Center(
        child: Text("出现错误了~"),
      ),
    );
  };

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const title = 'flutter企业级UI管理框架';
  @override
  Widget build(BuildContext context) {
    ///树展开
    Mgr().isAllExpanded = true;

    ///
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
        canvasColor: Colors.transparent,
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.green),
        scaffoldBackgroundColor: AppTheme.notWhite,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Login(),
        'home': (context) => const Home(),
      },
    );
  }
}
