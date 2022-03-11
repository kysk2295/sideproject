import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ex0205/screen/modelingScreen.dart';
import 'package:ex0205/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'imageFullScreen.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductDetailScreenState();
  }

}
final List<String> imgList = [
  'https://mambo13004.files.wordpress.com/2021/11/scarlet-spider-9.jpg',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(

      child: Image.network(item, fit: BoxFit.cover, ),
    ))
    .toList();

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  int _current = 0;
  final CarouselController _controller = CarouselController();
  late int value;
  bool toggle = false;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
            Container(
              height: 410.h,
              margin: EdgeInsets.fromLTRB(0, 85.h, 0, 0),
              padding: EdgeInsets.all(0),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                    height: 410.h,
                  autoPlay: true,
                  aspectRatio: 300.w/410.h,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index,reason){
                    setState(() {
                      _current=index;
                    });
                  },
                ),
                itemBuilder: (ctx,index,readIdx){
                  return  Container(
                      child: _current == index ? InkWell(
                        onDoubleTap: () async {
                          value =  await Get.to(ImageFullScreen(), arguments: index);
                          setState(() {
                            index = value;
                            //이후에서 받은 값으로 이동
                            _controller.animateToPage(index);
                            print(index);
                          });
                        },
                        child: Hero(tag: 'hero',
                            child: Image.network(imgList[index], fit: BoxFit.cover, )),
                      ):

                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.saturation,
                        ),
                        child: Image.network(imgList[index], fit: BoxFit.cover, )),
                      );
                },
                carouselController: _controller, itemCount: 6,
              ),

            ),
            SizedBox(height: 28.h,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                : Colors.grey)
                .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
            );
            }).toList(),
            ),
            SizedBox(height: 30.h,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.w),
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 타원 3
                  Container(
                      width: 18.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                        shape: BoxShape.circle
                      )
                  ),

                  SizedBox(width: 10.w,),
                  // Large Title
                  Text(
                      "Artist Name",
                      style:TextStyle(
                          color:  const Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Sarabun",
                          fontStyle:  FontStyle.normal,
                          fontSize: 13.sp
                      ),
                      textAlign: TextAlign.end
                  )


                ],),
            ),
            SizedBox(height: 3.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.w,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Large Title
                  Text(
                      "Product name",
                      style:  TextStyle(
                          color:  const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Sarabun",
                          fontStyle:  FontStyle.normal,
                          fontSize: 26.sp
                      ),
                      textAlign: TextAlign.left
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          toggle=!toggle;
                        });
                      },padding: EdgeInsets.only(right: 0),constraints: BoxConstraints(), icon: !toggle ? Image.asset('assets/images/heart.png',
                        width: 23.w,height: 23.h,) : Image.asset('assets/images/hart.png',
                        width: 28.w,height: 28.h,),iconSize: 28,
                      ),
                      SizedBox(width: 10.w,),
                      IconButton(onPressed: (){
                        Get.to(ModelingScreen());
                      },padding: EdgeInsets.only(right: 0),constraints: BoxConstraints(), icon: Image.asset('assets/images/modeling.png',
                        width: 23.w,height: 23.h,),iconSize: 23,
                      )
                    ],
                  )


                ],

              ),
            ),
            SizedBox(height: 10.h,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Title3
                  Text(
                      "Released to",
                      style: TextStyle(
                          color:  const Color(0xffffffff),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Sarabun",
                          fontStyle:  FontStyle.normal,
                          fontSize: 14.sp
                      ),
                      textAlign: TextAlign.left
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title3
                  Text(
                      "87 %",
                      style:  TextStyle(
                          color:  const Color(0xffffffff),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Sarabun",
                          fontStyle:  FontStyle.normal,
                          fontSize: 44.sp
                      ),
                      textAlign: TextAlign.left
                  ),
                  // Title3
                  RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                style:  TextStyle(
                                    color:  const Color(0xfff1a09d),
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Sarabun",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 21.sp
                                ),
                                text: "44589 "),
                            TextSpan(
                                style:  TextStyle(
                                    color:  const Color(0xffffffff),
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Sarabun",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 21.sp
                                ),
                                text: "/ 50000")
                          ]
                      )
                  )
                ],

              ),
            ),
            SizedBox(height: 25.h,),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 8.w),
            //     child: productGridview())

          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}