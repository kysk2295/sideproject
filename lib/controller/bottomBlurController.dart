import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBlurController extends GetxController{
  bool selected = false;
  bool searchselected = false;
  bool desc_selected = false;


  changeState(){
    selected=!selected;
    update();
  }
  changeState2(){
    searchselected=!searchselected;
    update();
  }
  changeState3(){
    desc_selected = !desc_selected;
    update();
  }
  changeNothing() {
    selected=selected;
    searchselected=searchselected;
    update();
  }

}