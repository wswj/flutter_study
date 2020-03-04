import 'package:flutter/material.dart';

class AnimatePositiveIcon extends StatefulWidget {
  AnimatePositiveIcon({Key key, @required this.size, this.callback})
      : super(key: key);
  final double size;
  final VoidCallback callback;
  _AnimatePositiveIconState createState() => _AnimatePositiveIconState();
}

class _AnimatePositiveIconState extends State<AnimatePositiveIcon>
    with TickerProviderStateMixin {
  AnimationController _controller1;
  AnimationController _controller2;
  AnimationController _controller3;

  Animation<double> _animation1;
  Animation<double> _animation2;
  Animation<double> _animation3;

  Animation<double> curAnimation;

  Color curColor;

  @override
  void initState() {
    super.initState();
    print("动画执行");
    _controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _controller3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));

    curColor = Colors.grey[100];
    _animation1 = Tween(begin: 1.0, end: 0.0).animate(_controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("数值此时为===============================${_animation1.value}");
          print("监听1");
          _controller2.forward(from: 0);
          curAnimation = _animation2;
          curColor = Colors.redAccent;
        }
      });

    _animation2 = Tween(begin: 0.0, end: 1.2).animate(_controller2)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        print("监听2");
        if (status == AnimationStatus.completed) {
          _controller3.forward(from: 0);
          curAnimation = _animation3;
        }
      });

    _animation3 = Tween(begin: 1.2, end: 1.0).animate(_controller3)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        print("监听3");
        if (status == AnimationStatus.completed) {
          //widget.callback();
          print("数值为===============================${_animation1.value}");
        }
      });
    // _controller1.forward(from: 0).then((_) {
    //   _controller2.forward(from: 0).then((_){
    //     _controller3.forward(from: 0);
    //   });
    // });
    
    print("数值之前为===============================${_animation1.value}");
    //_controller1.forward(from: 0);
  }
  

  @override
  Widget build(BuildContext context) {
    curAnimation = _animation1;
    _controller1.forward(from: 0);
    return Container(
      child: Icon(
        Icons.favorite,
        size: widget.size * curAnimation.value,
        color: curColor,
      ),
    );
  }
}