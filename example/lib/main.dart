import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:myplus/myplus.dart';

import 'constans/constans.dart';
import 'view/BaseView/login.dart';

Future<void> main() async {
  /// 确保初始化
  WidgetsFlutterBinding.ensureInitialized();

  /// 自定义报错提示
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    FlutterError.dumpErrorToConsole(flutterErrorDetails);
    if (kReleaseMode) {
      //上传错误
    }
    return const Material(
      child: Center(
        child: Text('出现错误'),
      ),
    );
  };

  // await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ])
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const title = 'flutter企业级UI管理框架';
  @override
  Widget build(BuildContext context) {
    ///树展开
    Mgr().isAllExpanded = true;

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
      },
    );
  }
}
