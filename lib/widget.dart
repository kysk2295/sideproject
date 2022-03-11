import 'package:ex0205/screen/productDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class productGridview extends StatelessWidget{

  final List<dynamic> data;
  productGridview( {required this.data});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return GridView.builder(
    itemCount: data.length,
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: ScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 189.w/352.h,
    mainAxisSpacing: 7.h,
    crossAxisSpacing: 10.w
    ) , itemBuilder: (_,index){

    return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    InkWell(
    onTap: (){
    Get.to(ProductDetailScreen(
    ));
    },
    child: Container(
    width: 199.w,
    height: 302.h,
    decoration: BoxDecoration(
    color: const Color(0xffb7b7b7)
    ),
    child: GridTile(
    child: Container(
      child: Image.network(data[index]['thumbnailUrl'], fit: BoxFit.cover,),
    ),
    footer: GridTileBar(
    leading: Container(margin: EdgeInsets.only(top: 10.h),child: Image.asset('assets/images/like.png', width: 20.w, height: 20.h, )),
    backgroundColor: Colors.transparent,
    ),
    ),
    ),
    ),
    SizedBox(height: 10.h,),
    Padding(
    padding: EdgeInsets.only(left: 10.w)
    ,child: Text(
    data[index]['productName'],
    style: TextStyle(
    color:  const Color(0xffffffff),
    fontWeight: FontWeight.w300,
    fontFamily: "Sarabun",
    fontStyle:  FontStyle.normal,
    fontSize: 15.sp
    ),
    textAlign: TextAlign.left
    ),
    ),
    // 87 %
    SizedBox(height: 3.h,),
    Padding(
    padding: EdgeInsets.only(left: 10.w)
    ,child: Text(
    "87 %",
    style: TextStyle(
    color:  const Color(0xffd9d9d9),
    fontWeight: FontWeight.w400,
    fontFamily: "Sarabun",
    fontStyle:  FontStyle.normal,
    fontSize: 15.sp
    ),
    textAlign: TextAlign.left
    ),
    )
    ],
    );

    });
  }
}