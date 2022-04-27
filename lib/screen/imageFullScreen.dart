import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                          widget.data['productName']+"${value}",
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
                          widget.data['artistName'],
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