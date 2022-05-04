import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ex0205/controller/bottomBlurController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';

class ImageFullScreen extends StatefulWidget{

  final dynamic data;
  ImageFullScreen({required this.data});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _ImageFullScreenState();
  }

}

class _ImageFullScreenState extends State<ImageFullScreen> {

  late List<String> imgList;
  final CarouselController _controller = CarouselController();
  int value = Get.arguments;
  final controller = Get.put(BottomBlurController());

  @override
  void initState() {
    setState(() {
      imgList = widget.data['imgUrl'].join().split(",");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //페이지 위치

    return Scaffold(
        body: controller.desc_selected  ?  blurBody(): buildBody()

    );

  }
  Widget blurBody(){
    return Stack(
      children: [
    ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
    child: buildBody(),  // Widget that is blurred
    ),

        // ProAnimatedBlur(
        //   blur: controller.desc_selected ? 100 : 10.00,
        //   duration: Duration(milliseconds: 1000),
        //   curve: Curves.easeIn,
        //   child:  ImageFiltered(
        //    imageFilter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        //    child: buildBody(),  // Widget that is blurred
        //    ),
        // ),


        Visibility(
            visible: controller.desc_selected,
            child:
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40,),
                child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                  style: TextStyle(color: Colors.white),),
              ),
            )
        ),
      ],
    );
  }
  Widget buildBody(){
      return Stack(
          children: [
            CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1,
                    height: double.infinity,
                    initialPage: value,
                    onPageChanged: (index, reason){

                      setState(() {
                        value=index;
                      });
                    }
                ),
                items: imgList
                    .map((item) => Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                      child:
                      InkWell(
                        onDoubleTap: (){
                          Get.back(result: value);
                        },
                        onTap: (){
                          setState(() {
                            controller.changeState3();
                          });

                          print('hi');
                        },
                        onLongPress: (){
                          setState(() {
                            controller.changeState3();
                          });

                        },
                        child: Hero(tag: 'hero'
                          ,child: Image.network(item, fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center,),),
                      )),
                )).toList(), carouselController: _controller
            ),


            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(10.w, 40.h, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){
                      Get.back(result: value);
                    }, icon: Image.asset('assets/images/back.png'),)
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(30.w, 0, 0, 70.h),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Large Title
                    Text(
                        widget.data['productName']+"${value}",
                        style: TextStyle(
                            color:  Colors.black,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Sarabun",
                            fontStyle:  FontStyle.italic,
                            fontSize: 40.sp
                        ),
                        textAlign: TextAlign.left
                    ),
                    // Large Title
                    SizedBox(height: 5.h,),
                    Text(
                        widget.data['artistName'],
                        style: TextStyle(
                            color:  Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Sarabun",
                            fontStyle:  FontStyle.normal,
                            fontSize: 18.sp
                        ),
                        textAlign: TextAlign.left
                    ),
                    Text(
                        '+ details',
                        style: TextStyle(
                            color:  Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Sarabun",
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.sp
                        ),
                        textAlign: TextAlign.left
                    ),
                    SizedBox(height: 60.h,),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 7.w,
                              height: 7.h,
                              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.white)
                                      .withOpacity(value == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
      );
  }
}

