import 'dart:ui' as ui; // 调用window拿到route判断跳转哪个界面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_module/homePage.dart';
import 'package:flutter_module/myApp.dart';
import 'package:flutter_module/dbStore.dart';

// 默认是StandardMethodCodec
final t_methodChannel = const MethodChannel('com.base.test/route');

void main() {
  WidgetsFlutterBinding.ensureInitialized();

//  runApp(EnterApp(ui.window.defaultRouteName));

  t_methodChannel.setMethodCallHandler(platformCallHandler);

  flutterTests();

  /* 通过Handler配置
  t_methodChannel.setMethodCallHandler(platformCallHandler);
  */
}

class EnterApp extends StatefulWidget {
  String _routeName;
  EnterApp(this._routeName);
  EnterAppState createState() => EnterAppState();
}

class EnterAppState extends State<EnterApp> {
  @override
  Widget build(BuildContext context) {
    Map routeDic = <String, Widget> {
      "/myApp": MyAppPage(),
      "/home": MyHomePage()
    };
    print('EnterAppState   ===== build   ${widget._routeName}');
    return new MaterialApp(
        title: '测试',
        initialRoute: widget._routeName,
        home: routeDic[widget._routeName],
        /*
        routes:  <String, WidgetBuilder> {
          "/myApp": (context) => MyAppPage(),
          "/home": (context) => MyHomePage()
        }
        */
    );
  }
}

Future <dynamic> platformCallHandler(MethodCall call) async {
  print("Flutter---" + call.arguments['route']);
  if (call.method == 'InitialRoute') {
    runApp(EnterApp(call.arguments['route']));
  }
  return '';
}

void blockTest(backBlock(String str)) {
  backBlock('succes');
}

void flutterTests() {
  //回调函数
  blockTest((String str) {
    print('block_test:===$str');
  });

  // 实例方法串行调用
  LCDataBaseStorage()
    ..test();

  LCKVStorage()
    ..setValueForKey('hello world！！！', 'key')
    ..valueForKey('key');

  LCDirectoryPath.documentDir.then((path) => {

  }).catchError((err) => {

  });
}