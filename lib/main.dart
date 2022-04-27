import 'dart:convert';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/bottomBlurController.dart';
import 'package:http/http.dart' as http;


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
      builder: (BuildContext context) =>
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
            home: MyHomePage(),
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
  int _selectedIndex = 0;
  List pages = [
    HomeScreen(),
    SubscribeScreen(),
    LikeScreen(),
    ProfileScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        child: Image.asset('assets/images/home.png', width: 18, height: 18,)),
        label: 'Home',
        activeIcon: Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: Image.asset('assets/images/home.png', width: 18,
              height: 18,
              color: Colors.white,))),
    BottomNavigationBarItem(
      icon: Container(
          margin: EdgeInsets.only(bottom: 5.h),
          child: Image.asset('assets/images/sub.png', width: 18, height: 18,)),
      label: 'Subscribe',
      activeIcon: Container(
          margin: EdgeInsets.only(bottom: 5.h),
          child: Image.asset('assets/images/sub.png', width: 18,
            height: 18,
            color: Colors.white,)),),
    BottomNavigationBarItem(
      icon: Container(margin: EdgeInsets.only(bottom: 5.h),
          child: Image.asset('assets/images/like.png', width: 18, height: 18,)),
      label: 'Liked',
      activeIcon: Container(margin: EdgeInsets.only(bottom: 5.h),
          child: Image.asset('assets/images/like.png', width: 18,
            height: 18,
            color: Colors.white,)),),
    BottomNavigationBarItem(icon: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        child: Image.asset(
          'assets/images/profile.png', width: 18, height: 18,)),
        label: 'Profile',
        activeIcon: Container(margin: EdgeInsets.only(bottom: 5.h),
            child: Image.asset('assets/images/profile.png', width: 18,
              height: 18,
              color: Colors.white,))),


  ];

  //FutureBuilder을 쓸때 build함수 내에서 쓰면 여러번 호출 된다.
  //이 경우에 한번만 호출하고 싶으면 build함수 밖에서 future를 처리해줘야 한다.
  //그래서 변수를 만들어주고 inistate함수에서 이를 초기화시켜준다.
  late Future<String> data;

  @override
  Widget build(BuildContext context) {
    print('hi');
    return Scaffold(
        body: FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              //로그인에서 sharedpreference 저장 없이 바로 넘어올때
              if(Get.arguments=='pass')
                {
                  print('asdf');
                  return Scaffold(
                      body: pages[_selectedIndex],
                      bottomNavigationBar: GetBuilder<BottomBlurController>(
                        builder: (_) {
                          if (_.selected) {
                            return SizedBox();
                          }
                          else if (_.searchselected) {
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
              //자동로그인
              else if (snapshot.connectionState == ConnectionState.done
                  && snapshot.data.toString() != 'success' ) {
                print(snapshot.data.toString() + "asdfasdf");

                return LoginScreen();
              }

              else {
                return Scaffold(
                    body: pages[_selectedIndex],
                    bottomNavigationBar: GetBuilder<BottomBlurController>(
                      builder: (_) {
                        if (_.selected) {
                          return SizedBox();
                        }
                        else if (_.searchselected) {
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
            })
    );
  }

  @override
  void initState() {
    data = _autoLogin();
  }
}

Future<String> _autoLogin() async{

  var flag='fail';

  final prefs = await SharedPreferences.getInstance();
  print(prefs.getStringList('info')![0]);

  if(prefs.getStringList('info')!.isNotEmpty){
    print('hi');
    var res = await http.post(
      Uri.parse('http://192.168.45.52:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email':prefs.getStringList('info')![0],
        'password':prefs.getStringList('info')![1],
      }),
    ).catchError((error){
      print(error);
      flag='fail';
    });

    if(res.statusCode==302){
      print('로그인 성공2');
      flag='success';
    }
    else {
      print('로그인 실패');
      flag='fail';

    }
  }
  else {
    print('로그인 실패2');
    flag='fail';
  }

  return flag;
}
