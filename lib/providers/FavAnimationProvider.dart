import 'package:flutter/material.dart';

class FavAnimation extends ChangeNotifier{
  AnimationController controller;
  showAnimation(){
    controller.forward(from:0);
  }
}