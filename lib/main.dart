import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "抖音",
      home: Container(
        decoration: BoxDecoration(color:Colors.yellowAccent),
        child: Home(),
        ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //获取屏幕的宽度=========需要注意的是该方法只有在MateriaApp的home属性中的组件中才有效
    double screen_width=MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          height: 100,
          width: screen_width,
          child: Container(
            decoration:BoxDecoration(color:Colors.redAccent)
          ) 
          )
      ],
    );
  }
}