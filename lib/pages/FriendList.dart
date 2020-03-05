import 'package:flutter/material.dart';

class AtFriendPage extends StatelessWidget {
  const AtFriendPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx=MediaQuery.of(context).size.width/750;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          //color: Colors.red,
          //width:300*rpx,
          child:FlatButton(
           
          child: Icon(Icons.close,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          }
        )
        ),
        title: Text("@好友"),
        bottom: PreferredSize(child: Container(
          color: Colors.grey[500],
          //decoration: BoxDecoration(border:BorderRadius.circular(5*rpx)),
          margin: EdgeInsets.symmetric(horizontal:20*rpx,vertical: 5*rpx),
          padding: EdgeInsets.symmetric(horizontal:20*rpx),
          child:TextField(decoration: InputDecoration(
          hintText:"搜索用户名",
          icon:Icon(Icons.search),
          fillColor: Colors.grey[100],
          //border: BorderRadius.circular(5*rpx)
        ),)), preferredSize: Size.fromHeight(50*rpx)),
      ),
      
    );
  }
}