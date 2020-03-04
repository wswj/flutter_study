import 'package:flutter/material.dart';
import 'package:flutter_myf/providers/FavAnimationProvider.dart';
import 'package:provider/provider.dart';

class AnimatePositiveIcon extends StatefulWidget {
  AnimatePositiveIcon({Key key,this.size,this.pctx}) : super(key: key);
  final size;
  final pctx;
  @override
  _AnimatePositiveIconState createState() => _AnimatePositiveIconState();
}

class _AnimatePositiveIconState extends State<AnimatePositiveIcon> with TickerProviderStateMixin{
  AnimationController controller1;
  AnimationController controller2;
  AnimationController controller3;

  Animation animation1;
  Animation animation2;
  Animation animation3;
  Animation currAnimation;
  FavAnimation favAnimation;
  Color curColor;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("执行");
    favAnimation=Provider.of<FavAnimation>(widget.pctx);
    controller1=AnimationController(vsync:this,duration:Duration(milliseconds:200));
    controller2=AnimationController(vsync:this,duration:Duration(milliseconds:300));
    controller3=AnimationController(vsync:this,duration:Duration(milliseconds:100));
    
    curColor=Colors.grey[100];
    animation1=Tween(begin:1.0,end:0.0).animate(controller1)..addListener((){
      setState((){});
    })..addStatusListener((status){
      if(status==AnimationStatus.completed){
        print("动画此时的值为${animation1.value}");
        controller2.forward(from:0.0);
        currAnimation=animation2;
        curColor=Colors.redAccent;
      }
    });
    animation2=Tween(begin:0.0,end:1.2).animate(controller2)..addListener((){
      setState((){});
    })..addStatusListener((status){
      if(status==AnimationStatus.completed){
        print("动画此时的值为${animation1.value}");
        print("动画此时的值为${animation2.value}");
        controller3.forward(from:0.0);
        currAnimation=animation3;
      }
    });
    animation3=Tween(begin:1.2,end:1.0).animate(controller3)..addListener((){
      setState((){
      });
    })..addStatusListener((status){
      if(status==AnimationStatus.completed){
        print("动画此时的值为${animation1.value}");
        print("动画此时的值为${animation2.value}");
        //controller3.forward(from:0.0);
        //currAnimation=animation3;
        controller1.reset();
        
        print("动画重置的值为${animation1.value}");
      }
    });
    currAnimation=animation1;
    controller1.forward(from:0);
    favAnimation.controller=controller1;
    // controller1.forward(from:0.0).then((_){
    //   controller2.forward(from:0).then(f)
    // });
  }
  
  @override
  Widget build(BuildContext context) {
    //
    return Container(
       child: Icon(Icons.favorite,size:widget.size*currAnimation.value,color:curColor),
    );
  }
}

class AnimateNegativeIcon extends StatefulWidget {
  AnimateNegativeIcon({Key key,this.size}) : super(key: key);
  final size;
  @override
  _AnimateNegativeIconState createState() => _AnimateNegativeIconState();
}

class _AnimateNegativeIconState extends State<AnimateNegativeIcon> with TickerProviderStateMixin{
  AnimationController controller1;
  AnimationController controller2;
  //AnimationController controller3;

  Animation animation1;
  Animation animation2;
  //Animation animation3;
  Animation currAnimation;
  //FavAnimation favAnimation;
  Color curColor;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("执行");
    //favAnimation=Provider.of<FavAnimation>(widget.pctx);
    controller1=AnimationController(vsync:this,duration:Duration(milliseconds:200));
    controller2=AnimationController(vsync:this,duration:Duration(milliseconds:300));
    //controller3=AnimationController(vsync:this,duration:Duration(milliseconds:100));
    
    curColor=Colors.redAccent;
    animation1=Tween(begin:1.0,end:1.2).animate(controller1)..addListener((){
      setState((){});
    })..addStatusListener((status){
      if(status==AnimationStatus.completed){
        print("动画此时的值为${animation1.value}");
        controller2.forward(from:0.0);
        currAnimation=animation2;
        curColor=Colors.grey[100];
      }
    });
    animation2=Tween(begin:1.2,end:1).animate(controller2)..addListener((){
      setState((){});
    })..addStatusListener((status){
      if(status==AnimationStatus.completed){
        print("动画此时的值为${animation1.value}");
        print("动画此时的值为${animation2.value}");
        //controller3.forward(from:0.0);
        //currAnimation=animation3;
      }
    });
    // animation3=Tween(begin:1.2,end:1.0).animate(controller3)..addListener((){
    //   setState((){
    //   });
    // })..addStatusListener((status){
    //   if(status==AnimationStatus.completed){
    //     print("动画此时的值为${animation1.value}");
    //     print("动画此时的值为${animation2.value}");
    //     //controller3.forward(from:0.0);
    //     //currAnimation=animation3;
    //     controller1.reset();
        
    //     print("动画重置的值为${animation1.value}");
    //   }
    // });
    currAnimation=animation1;
    controller1.forward(from:0);
    //favAnimation.controller=controller1;
    // controller1.forward(from:0.0).then((_){
    //   controller2.forward(from:0).then(f)
    // });
  }
  
  @override
  Widget build(BuildContext context) {
    //
    return Container(
       child: Icon(Icons.favorite,size:widget.size*currAnimation.value,color:curColor),
    );
  }
}