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
          // leading: Icon(Icons.arrow_left),
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
            //color: Colors.grey[300],
            padding: EdgeInsets.only(left:15),
            decoration: BoxDecoration(color: Colors.grey[300],borderRadius:BorderRadius.circular(10)),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                fillColor: Colors.grey,
                //取出输入框下的下划线
                border: InputBorder.none,
                //相当于placeholder
                hintText: "搜你所想"
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.airplanemode_active), onPressed: (){})
          ],
          ),
         body:TabBarView(
           children: <Widget>[
           Center(
             child:Text("1"),
           ),
           genContentList(),
           Center(
             child:Text("3"),
           ),
         ],
         controller: _controller,)
       ),
    );
  }
}

class Content{
  String title;
  String subTitle;
  String avatrUrl;
  String userName;
  String userDesc;
  Content(){
    title="Flutter中Expanded组件用法";
    subTitle="Expanded组件可以使Row、Column、Flex等子组件在其主轴方向上展开并填充可用空间(例如，Row在水平方向，Column在垂直方向)。如果多个子组件展开，可用空间会被其flex factor(表示扩展的速度、比例)分割。";
    avatrUrl="https://pics4.baidu.com/feed/f3d3572c11dfa9ec4bb203e8a405b505938fc189.jpeg?token=05d5bafd59a68bc7425f0459e0cc17d2&s=B5BF7B93061355C89EB43E670300C074";
    userName="wswj";
    userDesc="谢谢关注";
  }
}

genContentList(){
  Content content=Content();
  List<Content> list=List<Content>();
  List.generate(10, (index){
    list.add(content);
  });
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (BuildContext context,int index){
      return Card(
        elevation:2,
        child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom:10),
        child: ListTile(
          title:Text(content.title),
          subtitle: Column(
            children: <Widget>[
              Row(
            children:<Widget>[
              Container(
                width: 25,
                height: 25,
                child:CircleAvatar(backgroundImage:NetworkImage(content.avatrUrl)),
              ),
              SizedBox(width:10),
              Text(content.userName,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
              SizedBox(width:20),
              Text(content.userDesc)
            ]
          ),
          //text的style的height用来设置行高
          Text(content.subTitle,overflow:TextOverflow.ellipsis,maxLines:2,style: TextStyle(height:1.9),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("点赞10.评论20"),
              Icon(Icons.more_horiz),
            ],
          )
            ],
          )
        ),
      ),
      );
    }
  );
}