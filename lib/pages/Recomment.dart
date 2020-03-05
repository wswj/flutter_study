//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_myf/pages/FriendList.dart';
import 'package:flutter_myf/providers/RecommendProvider.dart';
import 'package:provider/provider.dart';

class ReplyFullList extends StatelessWidget {
  const ReplyFullList({Key key,this.pCtx}) : super(key: key);
  final BuildContext pCtx;
  @override
  Widget build(BuildContext context) {
    double rpx=MediaQuery.of(context).size.width/750;
    RecommandProvider provider=Provider.of<RecommandProvider>(pCtx);
    Reply reply=provider.reply;
    List<Reply> replies=List<Reply>();
    replies.add(reply);
    replies.add(reply);
    replies.add(reply);
    //添加scrollerController保证所有的滑动组件使用同一个controller以解决cloumn组件里的listview组件不会有滑动效果
    ScrollController controller=ScrollController();
    return Scaffold(
      appBar: PreferredSize(child: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close,color:Colors.black), onPressed: (){Navigator.pop(context);})
        ],
        title: Text("10条评论",style: TextStyle(color:Colors.grey[700],fontSize: 25*rpx),),
        
      ), preferredSize: Size.fromHeight(80*rpx)),
      bottomNavigationBar: SafeArea(child: BottomReplyBar(pctx: pCtx)),
      body: SingleChildScrollView(
        controller:controller,
        child:Container(child: genReplyList(replies, controller),)
      ),

    );
  }
}


//主回复
class ReplyList extends StatelessWidget {
  const ReplyList({Key key,this.reply,this.controller}) : super(key: key);
  final Reply reply;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    List<Reply> replies=List<Reply>();
    replies.add(reply);
    replies.add(reply);
    replies.add(reply);
    double rpx=MediaQuery.of(context).size.width/750;
    return Container(
      
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children:<Widget>[
              Container(width:100*rpx,height:100*rpx,margin:EdgeInsets.only(left:10*rpx),child: CircleAvatar(backgroundImage:NetworkImage("${reply.replyMakerAvatar}")),),
              Container(width:540*rpx,child: ListTile(
                title:Text("${reply.replyMakerName}"),
                subtitle: Text("${reply.replyContent}",overflow: TextOverflow.ellipsis,maxLines: 2,),
              ),),
              Container(width:100*rpx,child: IconButton(icon: Icon(Icons.favorite), onPressed: (){}),)
            ]
          ),
          genAfterReplyList(replies,controller)
        ],
      ),
    );
  }
}

//子回复
class AfterReplyList extends StatelessWidget {
  const AfterReplyList({Key key,this.afterReply,this.controller}) : super(key: key);
  final Reply afterReply;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    double rpx=MediaQuery.of(context).size.width/750;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children:<Widget>[
              Container(width:100*rpx),
              Container(width:550*rpx,child: Row(
                children:<Widget>[
                  Container(width: 70*rpx,height: 70*rpx,child:CircleAvatar(backgroundImage:NetworkImage("${afterReply.replyMakerAvatar}"))),
                  Container(width:480*rpx,child:ListTile(
                title:Text("${afterReply.replyMakerName}"),
                //富文本组件========下面的功能为在文本后加上3天前
                subtitle: RichText(text:TextSpan(
                  style:TextStyle(color:Colors.black),
                  text: "${afterReply.replyContent}",children: <TextSpan>[
                    TextSpan(text:"3天前")
                ]),)
              ))
                ]
              ),),
              Container(width:100*rpx)
            ]
          )
        ],
      ),
    );
  }
}

genReplyList(List<Reply> list,ScrollController controller){
  return ListView.builder(
    shrinkWrap: true,
    controller: controller,
    itemCount: list.length,
    itemBuilder:(context,index){
    return ReplyList(reply:list[index],controller:controller);
    } );
}

genAfterReplyList(List<Reply> list,ScrollController controller){
  return ListView.builder(
    //让listview扩展到允许的最大大小
    shrinkWrap: true,
    controller: controller,
    itemCount: list.length<=2?list.length:2,
    itemBuilder:(context,index){
    return AfterReplyList(afterReply:list[index],controller:controller);
    } );
}

class BottomReplyBar extends StatelessWidget {
  const BottomReplyBar({Key key,this.pctx}) : super(key: key);
  final BuildContext pctx;
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller=TextEditingController();
    double toBottom=MediaQuery.of(context).viewInsets.bottom;
    double rpx=MediaQuery.of(context).size.width/750;

    return Container(
      padding: EdgeInsets.only(bottom:toBottom),
      decoration: BoxDecoration(border:Border(top:BorderSide(color:Colors.grey[200],width:1))),
      child: Row(
        children:<Widget>[
          Expanded(
            child:Container(
              padding:EdgeInsets.only(left:30*rpx),
              child: TextField(controller:_controller,decoration:InputDecoration(hintText: "留下你的精彩评论",border:InputBorder.none)),
            )
          ),
          IconButton(icon: Icon(Icons.email,color:Colors.grey[500],size: 50*rpx,), onPressed: (){showAtFriendPage(context);}),
          IconButton(icon: Icon(Icons.face,size: 50*rpx,), onPressed: (){}),
          SizedBox(width:20*rpx)
        ]
      ) ,
    );
  }
}

showAtFriendPage(BuildContext context){
  Navigator.of(context).push(new MaterialPageRoute(
    builder: (BuildContext context){
    return AtFriendPage();
  },
  fullscreenDialog: true
  ));
}