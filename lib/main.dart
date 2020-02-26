import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_myf/shuertaProvider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "舒尔特方格",
//       home: ShuterCell(),
//     );
//   }
// }

// class ShuterCell extends StatefulWidget {
//   ShuterCell({Key key}) : super(key: key);

//   @override
//   _ShuterCellState createState() => _ShuterCellState();
// }

// class _ShuterCellState extends State<ShuterCell> with TickerProviderStateMixin{
//   int count;
//   List<int> data=List<int>();
//   List<int> curSel=List<int>();
//   List<AnimationController> controllers=List<AnimationController>();
//   List<Animation<Color>> animations=List<Animation<Color>>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     count=16;
//     //产生一组数据并添加到data数组中
//     List.generate(count, (index){
//       data.add(index+1);
//       //初始化AnimationController，其中duration为动画时长
//       controllers.add(AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds:500)),);
//       //初始化Animation添加动画
//       animations.add(
//         //颜色动画，从白色变为紫色
//         ColorTween(
//           begin: Colors.white,
//           end: Colors.purpleAccent
//         ).animate(controllers[index])..addListener((){
//           setState((){

//           });
//         })
//       );

//     });
//     //打乱list数组中元素的顺序
//     data.shuffle();
//   }

//   tapCell(i){
//     //lastSel已选数组中的最后一个值，如果集合curSel的长度为<0则赋值为0
//     int lastSel=curSel.length>0?curSel.last:0;
//     //如果当前选择的数字-1=上一个选择的顺序则判定选择的顺序正确，动画为白到紫，否则动画为白到红
//     if(data[i]-1==lastSel){
//       animations[i]=ColorTween(
//           begin: Colors.white,
//           end: Colors.purpleAccent
//         ).animate(controllers[i])..addListener((){
//           setState((){});
//         });
//         curSel.add(data[i]);   
//     }else{
//       animations[i]=ColorTween(
//           begin: Colors.white,
//           end: Colors.red
//         ).animate(controllers[i])..addListener((){
//           setState((){});
//         });
//     }
//     //reverse为结束动画效果
//     controllers[i].forward(from:0).then((_)=>controllers[i].reverse());
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:Text("舒尔特方格"),
//       ),
//       body: GridView.count(
//         crossAxisCount: 4,
//         children: 
//         //返回一个container集合
//         List.generate(count, (index)=>
//             InkWell(
//               onTap: (){tapCell(index);},
//               child: Container(
//               child:Center(child:Text("${data[index]}",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 28),)),
//               decoration: BoxDecoration(
//                 border:Border.all(width:2),
//                 //修改容器的颜色为动画的颜色值
//                 color: animations[index].value
//               ),
//               ),
//             )
//         ),
//     )
//     );
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>ShuerterProvider())
      ],
      child: Consumer<ShuerterProvider>(builder: (context,counter,_){
        return Container(
          child: MaterialApp(
            title: "舒尔特方格",
            home: ShuterCell()
    ),
        );
      }),
    );
  }
}

class ShuterCell extends StatefulWidget {
  ShuterCell({Key key}) : super(key: key);

  @override
  _ShuterCellState createState() => _ShuterCellState();
}

class _ShuterCellState extends State<ShuterCell> with TickerProviderStateMixin{
  //int count;
  List<int> data=List<int>();
  List<int> curSel=List<int>();
  List<AnimationController> controller;
  List<Animation<Color>> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("初始化");
    controller=List<AnimationController>();
    animation=List<Animation<Color>>();
    curSel = List<int>();
    //   //初始化AnimationController，其中duration为动画时长
    //   controllers.add(AnimationController(
    //     vsync: this,
    //     duration: Duration(milliseconds:500)),);
    //   //初始化Animation添加动画
    //   animations.add(
    //     //颜色动画，从白色变为紫色
    //     ColorTween(
    //       begin: Colors.white,
    //       end: Colors.purpleAccent
    //     ).animate(controllers[index])..addListener((){
    //       setState((){

    //       });
    //     })
    //   );

    // });
    // //打乱list数组中元素的顺序
  }

 
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShuerterProvider>(context);
    int count=provider.count;
    //print("count值为${provider.count}");
    // controller=List<AnimationController>();
    // animation=List<Animation<Color>>();
    print("provider长度${animation.length}");
    //curSel = List<int>();
    for (int i = 0; i < count; i++) {
      controller.add(AnimationController(
          duration: const Duration(milliseconds: 500), vsync: this));
      animation.add(ColorTween(
        begin: Colors.white,
        end: Colors.purpleAccent,
      ).animate(controller[i])
        ..addListener(() {
          // setState(() {

          // });
        }));
    }

    print("animation长度为${animation.length}");



    //这里使用foreach来添加到provider中是因为如果使用animation.clear();方法来清空集合会使原来所附的值变为空，如下最后得到的provider为空
        //provider.animations=animation;
        //animation.clears();



    animation.forEach((item){
      provider.animations.add(item);
    });
    
    
    //provider.animations = animation;
    
    controller.forEach((item){
      provider.animationControllers.add(item);
    });
    //provider.animationControllers = controller;
      animation.clear();
      controller.clear();
    // setState(() {
    //   animation.clear();
    //   controller.clear();
    // });
    return Scaffold(
      appBar: AppBar(
        title:Text("舒尔特方格"),
      ),
      body: Column(
        children: <Widget>[
        Container(
        child: GridView.count(
          shrinkWrap: true,
        crossAxisCount: sqrt(count).round(),
        children: 
        //返回一个container集合
        List.generate(count, (index)=>
            InkWell(
              onTap: (){provider.tapCell(index);},
              child: Container(
              //height: 60,
              child:Center(child:Text("${provider.data[index]}",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 28),)),
              decoration: BoxDecoration(
                border:Border.all(width:2),
                //修改容器的颜色为动画的颜色值
                color: provider.animations[index].value
              ),
              ),
            )
        ),
    ),
        ),
    CountTimer()
        ],
      )
    );
  }
}

class CountTimer extends StatefulWidget {
  CountTimer({Key key}) : super(key: key);

  _CountTimerState createState() => _CountTimerState();
}

class _CountTimerState extends State<CountTimer> {
  Timer time;
  double totalTime = 0;
  bool ifStarted = false;
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShuerterProvider>(context);

    return SizedBox(
        height: 200,
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    "${provider.totalTime.toStringAsFixed(1)}",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Container(
                child: Flexible(
              flex: 2,
              child: MaterialButton(
                // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                splashColor: Colors.transparent,
                color: Colors.blueAccent,
                onPressed: () {
                  provider.changeCount();
                },
                child: Text(
                  provider.count==16 ? "25格" : "16格",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )),
            Container(
                child: Flexible(
              flex: 2,
              child: MaterialButton(
                // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                splashColor: Colors.transparent,
                color: Colors.blueAccent,
                onPressed: () {
                  provider.resetValue();
                },
                child: Text(
                  "换一题",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )),
          ],
        ));
  }
}