import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:ex0205/screen/homeScreen.dart';
import 'package:ex0205/screen/likeScreen.dart';
import 'package:ex0205/screen/loginScreen.dart';
import 'package:ex0205/screen/profileScreen.dart';
import 'package:ex0205/screen/subscribeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'bottomBlurController.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: Size(428,926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () =>
          GetMaterialApp(
            //... other code
            builder: (context, widget) {
              //add this line
              ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            theme: ThemeData(
              primaryColor: Color(0xff000000),
              accentColor: Color(0xffF25520),
              textTheme: TextTheme(
                //To support the following, you need to use the first initialization method
                  bodyText1: TextStyle(
                      color:  const Color(0xffffffff),
                      fontWeight: FontWeight.w300,
                      fontFamily: "Sarabun",
                      fontStyle:  FontStyle.normal,
                  ),
              ),
            ),
            home: LoginScreen(),
            debugShowCheckedModeBanner: false,
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(BottomBlurController());
  int _selectedIndex =0;
  List pages=[
    HomeScreen(),
    SubscribeScreen(),
    LikeScreen(),
    ProfileScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(icon: Container(
        margin: EdgeInsets.only(bottom: 5.h),child: Image.asset('assets/images/home.png', width: 18, height: 18, )), label: 'Home',
    activeIcon:Container(
  margin: EdgeInsets.only(bottom: 5.h),child: Image.asset('assets/images/home.png',width: 18, height: 18, color: Colors.white,)) ),
    BottomNavigationBarItem(icon: Container(
  margin: EdgeInsets.only(bottom: 5.h),child: Image.asset('assets/images/sub.png',width: 18, height: 18,)), label: 'Subscribe',
    activeIcon:Container(
  margin: EdgeInsets.only(bottom: 5.h),child: Image.asset('assets/images/sub.png',width: 18, height: 18, color: Colors.white,)), ),
    BottomNavigationBarItem(icon: Container(margin: EdgeInsets.only(bottom: 5.h),child: Image.asset('assets/images/like.png', width: 18, height: 18,)), label: 'Liked',
    activeIcon:Container(margin: EdgeInsets.only(bottom: 5.h),child: Image.asset('assets/images/like.png',width: 18, height: 18, color: Colors.white,)),),
    BottomNavigationBarItem(icon: Container(margin: EdgeInsets.only(bottom: 5.h),child: Image.asset('assets/images/profile.png', width: 18, height: 18,)), label: 'Profile',
    activeIcon: Container(margin: EdgeInsets.only(bottom: 5.h),child: Image.asset('assets/images/profile.png',width: 18, height: 18, color: Colors.white,))),


  ];

  @override
  Widget build(BuildContext context) {
    print('hi');
    
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar:  GetBuilder<BottomBlurController>(
        builder: (_){
          if (_.selected)
            {
              return SizedBox();
            }
          else if(_.searchselected) {
            return SizedBox();
          }
          else {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xf0161616),
              selectedItemColor: Colors.white,
              unselectedItemColor: Color(0xff707070),
              currentIndex: _selectedIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedFontSize: 10.sp,
              unselectedFontSize: 10.sp,

              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: bottomItems,);

          }
        },

      )
      //
    );
  }
}
