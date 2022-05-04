import 'package:blur/blur.dart';
import 'package:ex0205/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/bottomBlurController.dart';

class LikeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LikeScreenState();
  }

}

class _LikeScreenState extends State<LikeScreen>  with SingleTickerProviderStateMixin{

  late TabController _tabController;
  final controller = Get.put(BottomBlurController());
  final _tabText = ['ALL PRODUCT', 'RELEASE AVAILABLE'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context,bool innerBoxIsControlled){
                  return [
                    SliverAppBar(
                    pinned: true,
                    floating: true,
                    backgroundColor: Theme.of(context).primaryColor,
                    expandedHeight: 100.h,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(74.h),
                      child: Container(
                        height: 74.h,
                        child: DefaultTabController(
                          length: _tabText.length
                          ,child:  Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children :
                            [
                              TabBar(
                                indicatorWeight: 2,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(width: 2.0,color: Theme.of(context).accentColor),
                                  insets: EdgeInsets.symmetric(horizontal: 50.w)
                                ),
                                controller: _tabController,
                                tabs: _tabText.map((String text){
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 5.h),
                                    child: Text(
                                      text,
                                      style: TextStyle(
                                        color:  Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Sarabun",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 15.sp,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  );
                                }
                                ).toList(),
                                isScrollable: true,
                              ),
                            ]
                        ),
                        ),
                      ),
                    ),
                  )
                  ];
                },
body:  Expanded(child: TabBarView(
  controller: _tabController,
  children: [
    // productGridview(),

  ],
)),
              ),
            ),


          ],
        ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController=TabController(length: 2, vsync: this);
  }
}