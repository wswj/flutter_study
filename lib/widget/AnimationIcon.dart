import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_myf/providers/RecommendProvider.dart';

class AnimationIconWidget extends StatefulWidget {
  AnimationIconWidget({Key key,
      @required this.animationList,
      @required this.icon,
      @required this.size,
      this.callback,
      this.callbackDelay,
      this.provider
      }) : super(key: key);
      //定义动画类列表
      final List<IconAnimationStage> animationList;
      //动画所属的图标
      final IconData icon;
      //回调方法
      final VoidCallback callback;
      //图标尺寸
      final double size;
      //延迟时间
      final Duration callbackDelay;
      //provider
      final RecommandProvider provider;

  @override
  _AnimationIconWidgetState createState() => _AnimationIconWidgetState();
}

class _AnimationIconWidgetState extends State<AnimationIconWidget> with TickerProviderStateMixin{
  List<IconAnimationStage> anis=List<IconAnimationStage>();
  List<AnimationController> controllers=List<AnimationController>();
  List<Animation<double>> animations=List<Animation<double>>();
  Animation<double> curAnim;
  Color curColor;
  int curIndex=0;
  List<bool> ifAdded=List<bool>();
  double curSize;
  bool ifInit=true;


  //为动画添加监听 以及状态监听
  loopAnimation(index){
    //判断当前动画颜色，如果当前颜色是否为空，如果为空则取动画类列表中第一个类的颜色，否则当前色不变
    curColor=curColor==null ? anis.first.color : curColor;
    //启动动画
    if(index < controllers.length-1){
      if(!ifAdded[index]){
        animations[index]=animations[index]..addStatusListener((status){
                    if(status==AnimationStatus.completed){
            curAnim=animations[index+1];
            curColor=anis[index+1].color;

            controllers[index+1].forward(from:0);
            loopAnimation(index+1);
          }
        }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       )..addListener((){
          setState(() {
            
          });
        });
        ifAdded[index]=true;
      }
    }else if(index==controllers.length-1){ //如果当前索引为列表最后一个元素
      if(!ifAdded[index]){
        animations[index]=animations[index]..addStatusListener((status){
          curColor=anis[index].color;
          if(status==AnimationStatus.completed){
            if(widget.callback!=null){
              if(widget.callbackDelay==null){
                widget.callback();
              }else{
                Timer(widget.callbackDelay, (){
                  widget.callback();
                });
              }
            }

          }
        })..addListener((){
          setState(() {
            
          });
        });
        ifAdded[index]=true;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化时将传入的动画类赋值给anis动画类列表
    anis=widget.animationList;

    //根据传入的动画类初始化animationController和animation同时将ifAddde列表初始化并且均赋值为false
    List.generate(anis.length, (index){
      var curAni=anis[index];
      ifAdded.add(false);
      //为AnimationController列表添加元素
      controllers.add(AnimationController(vsync: this,duration: anis[index].duration));
      //为Animation列表添加元素
      animations.add(Tween(begin: curAni.start, end: curAni.end)
          .animate(controllers[index]));
    });
    //将当前动画赋值为列表第一个元素
    curAnim=animations.first;
    //调用递归
    loopAnimation(0);
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        controllers.first.forward(from: 0);
      },
      icon: Icon(
        widget.icon,
        size: widget.size * curAnim.value,
        color: curColor,
      ),
    );
  }
}


//图标动画类
//start：动画开始值
//end：动画结束值
//color：图标颜色
//duration：动画时长
class IconAnimationStage {
  double start;
  double end;
  Color color;
  Duration duration;

  IconAnimationStage({this.color, this.duration, this.end, this.start});
}
