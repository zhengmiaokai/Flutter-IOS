import 'package:flutter/material.dart';
import 'dart:ui' as ui;

final double kScreenWidth = ui.window.physicalSize.width/ui.window.devicePixelRatio;
final double kScreenHeight = ui.window.physicalSize.height/ui.window.devicePixelRatio;
final double kScreenScale = ui.window.devicePixelRatio;

class MyAppPage extends StatefulWidget {
  @override
  _MyAppPage createState() => _MyAppPage();
}

class _MyAppPage extends State<MyAppPage> {

  static String picUrl = 'http://attachments.gfan.com/forum/201606/25/0001033cc0l90arrt1sf3a.jpg';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        backgroundColor: Color.fromRGBO(100, 100, 100, 1)
      ),
      drawer: Drawer(
        child: ListView(
            scrollDirection: Axis.vertical,
            itemExtent: 60,
            children: List.generate(50, (index){
              return Container(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start ,
                      children: [Text("行数 $index", style: TextStyle(fontSize: 18))]
                  )
              );
            }))
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.blue), title: Text('首页', style: TextStyle(color: Colors.blue),)),
          BottomNavigationBarItem(icon: Icon(Icons.shop, color: Colors.black), title: Text('购物', style: TextStyle(color: Colors.black),))
        ],
        onTap: (index) {
          print('tabIndex $index');
        }
      ),
      body:  Center(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: List.generate(8, (index){
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(onPressed: () {
                            print('文字 index:${index+1}');
                        }, child: Text('文字 index:${index+1}', textAlign: TextAlign.left,), padding: EdgeInsets.all(10),),
                          Icon(Icons.subway, color: Colors.blue, size: 24, textDirection: TextDirection.ltr),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(onPressed: () {
                            print('图片 index:${index+1}');
                        }, child: Image.network(picUrl,
                            height: 200, width: kScreenWidth - 20,
                            fit: BoxFit.fill,),
                          padding: EdgeInsets.only(left: 10, right: 10),),
                        ]
                    )
                  ],
              );
          })
        )
      )
    );
  }
}