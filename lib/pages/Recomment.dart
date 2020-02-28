//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_myf/providers/RecommendProvider.dart';
import 'package:provider/provider.dart';

class ReplyFullList extends StatelessWidget {
  const ReplyFullList({Key key,this.pCtx}) : super(key: key);
  final BuildContext pCtx;
  @override
  Widget build(BuildContext context) {
    double rpx=MediaQuery.of(context).size.width/750;
    RecommandProvider provider=Provider.of<RecommandProvider>(context);
    Reply reply=provider.reply;
    List<Reply> replies=List<Reply>();
    replies.add(reply);
    replies.add(reply);
    replies.add(reply);
    ScrollController controller=ScrollController();
    return Container(
      child: SingleChildScrollView(
        controller: controller,
        child:Column(
        mainAxisSize: MainAxisSize.min,
        children:<Widget>[
          Container(
            height:80*rpx,
            child:ListTile(
              leading:Container(width:10),
              trailing:IconButton(icon:Icon(Icons.close),onPressed:(){}),
              title: Text("共有3条评论"),
            )
          ),
          genReplyList(replies,controller),
          
        ]
      ),
      ),
    );
  }
}

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
              Container(width:100*rpx,child: CircleAvatar(backgroundImage:NetworkImage("${reply.replyMakerAvatar}")),),
              Container(width:550*rpx,child: ListTile(
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
                  Container(width: 70*rpx,child:CircleAvatar(backgroundImage:NetworkImage("${afterReply.replyMakerAvatar}"))),
                  Container(width:480*rpx,child:ListTile(
                title:Text("${afterReply.replyMakerName}"),
                subtitle: Text("${afterReply.replyContent}",overflow: TextOverflow.ellipsis,maxLines: 2,),
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
    shrinkWrap: true,
    controller: controller,
    itemCount: list.length<=2?list.length:2,
    itemBuilder:(context,index){
    return AfterReplyList(afterReply:list[index],controller:controller);
    } );
}