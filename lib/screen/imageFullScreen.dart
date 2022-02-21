import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImageFullScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _ImageFullScreenState();
  }

}

class _ImageFullScreenState extends State<ImageFullScreen> {

  final List<String> imgList = [
    'https://mambo13004.files.wordpress.com/2021/11/scarlet-spider-9.jpg',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  final CarouselController _controller = CarouselController();
  int value = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //페이지 위치

    return Scaffold(
        body: Stack(
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
                          "PRODUCT NAME ${value}",
                          style: TextStyle(
                              color:  const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Sarabun",
                              fontStyle:  FontStyle.normal,
                              fontSize: 37.sp
                          ),
                          textAlign: TextAlign.left
                      ),
                      // Large Title
                      Text(
                          "BY ARTIST NAME",
                          style: TextStyle(
                              color:  const Color(0xffffffff),
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
        )

    );

  }
}