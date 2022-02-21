import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:model_viewer/model_viewer.dart';

class ModelingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children :[ ModelViewer(
          src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
          alt: "A 3D model of an astronaut",
          ar: true,
          backgroundColor: Theme.of(context).primaryColor,
          autoRotate: true,
          cameraControls: true,
        ),
          Container(
            margin: EdgeInsets.fromLTRB(0.w, 40.h, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  Get.back();
                }, icon: Image.asset('assets/images/back.png'),)
              ],
            ),
          ),
      ]
      ),

    );
  }

}