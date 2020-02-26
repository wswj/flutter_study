import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TabBar",
      home: TabBrStu(),
    );
  }
}
class TabBrStu extends StatefulWidget {
  TabBrStu({Key key}) : super(key: key);

  @override
  _TabBrStuState createState() => _TabBrStuState();
}

class _TabBrStuState extends State<TabBrStu> with TickerProviderStateMixin{
  //设置字体大小
  double bigText=20;
  double smallText=15;
  TabController _controller;
  @override
  void initState() { 
    super.initState();
    _controller=TabController(length: 3, vsync: this,initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
          leading: Icon(Icons.arrow_left),
          bottom:TabBar(
            tabs: <Widget>[
            Tab(child:Text("页面1")),
            Tab(child:Text("页面2")),
            Tab(child:Text("页面3")),
            ],
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black12,
            labelStyle: TextStyle(fontSize: bigText),
            unselectedLabelStyle: TextStyle(fontSize:smallText),
            //下划线的高度
            indicatorWeight: 2,
            //下划线相当于tab容器的内边距,设置的为水平方向为20
            indicatorPadding: EdgeInsets.symmetric(horizontal:10),
            controller: _controller,
          ),
          title: Container(
            padding: EdgeInsets.only(left:5),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                fillColor: Colors.grey
              ),
            ),
          ),
          ),
         body:TabBarView(
           children: <Widget>[
           Center(
             child:Text("1"),
           ),
           Center(
             child:Text("2"),
           ),
           Center(
             child:Text("3"),
           ),
         ],
         controller: _controller,)
       ),
    );
  }
}