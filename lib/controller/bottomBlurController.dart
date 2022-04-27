import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBlurController extends GetxController{
  bool selected = false;
  bool searchselected = false;


  changeState(){
    selected=!selected;
    update();
  }
  changeState2(){
    searchselected=!searchselected;
    update();
  }
  changeNothing() {
    selected=selected;
    searchselected=searchselected;
    update();
  }

}