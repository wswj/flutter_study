import 'package:flutter/cupertino.dart';

class DouyingProvider extends ChangeNotifier{
  double rpx=2.88;
  getRpx(double deviceRpx){
    rpx=deviceRpx;
    notifyListeners();
  }
}