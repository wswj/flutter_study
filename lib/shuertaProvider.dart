import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShuerterProvider extends ChangeNotifier{
  //数字个数
  int count=16;
  int totalCell=0;
  List<int> data;
  List<int> curSel;
  List<AnimationController> animationControllers=List<AnimationController>();
  List<Animation<Color>> animations=List<Animation<Color>>();
  bool isStarted;
  Timer timer;
  double totalTime=0;
  
  //初始化参数
  ShuerterProvider(){
    totalCell=count;
    data=List<int>();
    List.generate(count, (index){
      data.add(index+1);
    });
    isStarted=false;
    data.shuffle();
    if(isStarted){
      timer.cancel();
    }
    totalTime=0;
    curSel=List<int>();
  }

  //重置表格数据
  resetValue(){
    isStarted=false;
    if(!isStarted){
      if(timer!=null){
        timer.cancel();
      }
    }

    totalTime=0;
    data = List<int>();
    List.generate(totalCell, (i) => data.add(i+1)).toList()..shuffle();
    data.shuffle();
    curSel = List<int>();
    notifyListeners();
  }


  ifLastCorrect(){
  if(curSel.length==count&&curSel.last==count){
    timer.cancel();
  }
}

tapCell(i){
  if(!isStarted){
    startPlay();
    isStarted=true;
  }
  int lastSel=curSel.length>0 ? curSel.last : 0;
  startPlay();
  if(data[i]-1==lastSel){
    animations[i]=ColorTween(begin:Colors.white,end:Colors.purpleAccent)
    .animate(animationControllers[i])
    ..addListener((){
      notifyListeners();
    });
    curSel.add(data[i]);
    ifLastCorrect();
  }else{
    animations[i]=ColorTween(begin:Colors.white,end:Colors.redAccent)
    .animate(animationControllers[i])
    ..addListener((){
      notifyListeners();
    });
  }

//如果点击完毕则提示成功信息
   if (data[i] == totalCell  && curSel.length == totalCell ) {
      timer.cancel();
      Fluttertoast.showToast(
          msg: "恭喜你，在${totalTime.toStringAsFixed(1)}秒内完成~",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[700],
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
  animationControllers[i].forward(from:0).then((_)=>animationControllers[i].reverse());
}

//开始计时
startRecordTime(){
  timer=Timer.periodic(Duration(milliseconds:100),(_){
    isStarted=true;
    totalTime+=0.1;
    notifyListeners();
  });
}

//停止计时
stopRecord(){
  timer.cancel();
}


//开始计时
startPlay(){
  if(!isStarted){
    tapStart();
  }
}

//计时开始
tapStart() {
    if (!isStarted) {
      timer = Timer.periodic(Duration(milliseconds: 100), (_) {
        totalTime += 0.1;
        totalTime = totalTime;
        notifyListeners();
      });
      isStarted = true;
    } else {
      timer.cancel();
      isStarted = false;
    }
    notifyListeners();
  }
//改变方格数量
changeCount(){
  if(count==16){
    count=25;
  }else{
    count=16;
  }
  totalCell=count;
  //resetValue();
  curSel=List<int>();
  data = List<int>();
  List.generate(totalCell, (i) => data.add(i+1)).toList()..shuffle();
  data.shuffle();
  if(timer!=null){
    timer.cancel();
  }
  totalTime=0;
  isStarted=false;
  // animationControllers=List<AnimationController>();
  // animations=List<Animation<Color>>();
  notifyListeners();
}

}


 
