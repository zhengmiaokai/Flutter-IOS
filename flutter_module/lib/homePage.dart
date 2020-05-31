import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<StatefulWidget> {

  // 创建一个给native的channel (类似iOS的通知）
  static const methodChannel = const MethodChannel('com.base.test/bridge');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(onPressed: () {
              _getLevel();
            }, child: Text("跳转ios新界面，参数是字符串")),
            FlatButton(onPressed: () {
              _sendData().then((res) {
                //正常
              }).catchError((err) {
                //异常
              });
            }, child: Text("传参，参数是map，看log")),
            FlatButton(onPressed: () {
              _updateStatus();
            }, child: Text("接收客户端相关内容")),
          ],
        ),
      ),
    );
  }

  void _getLevel() async {
    String reulit;
    try {
      reulit = await methodChannel.invokeMethod('getLevel');
    } on PlatformException catch (e) {
      reulit = '';
    }
    print("getLevel：$reulit}");
  }

  Future <void> _sendData() async {
    Map<String, dynamic> map = {"code": "200", "data":[1,2,3]};
    return methodChannel.invokeMethod('sendData', map);
  }

  void _updateStatus() async {
    dynamic result;
    try {
      result = await methodChannel.invokeMethod('updateStatus');
    } on PlatformException {
      result = "error";
    }
    if (result is String) {
      showModalBottomSheet(context: context, builder: (BuildContext context) {
        return Container(
          child: Center(
            child: Text(result, style: TextStyle(color: Colors.brown), textAlign: TextAlign.center,),
          ),
          height: 40.0
        );
      });
    }
  }
}