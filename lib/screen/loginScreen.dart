import 'dart:convert';

import 'package:ex0205/main.dart';
import 'package:ex0205/screen/signupScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'homeScreen.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }

}

class _LoginScreenState extends State<LoginScreen> {

  final _idTextEditController = TextEditingController();
  final _passwordEditController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var _idTextField = Container(
      height: 65.h,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Email',
              border: InputBorder.none,
            ),
            controller: _idTextEditController,
            style: TextStyle( fontSize: 18.sp),
            cursorColor: Colors.white,
            onChanged: (text){
              setState(() {

              });
            },
          ),
        ),
      ),
    );

    var _passwordTextField = Container(
      height: 65.h,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              border: InputBorder.none,
            ),
            obscureText: true,
            controller: _passwordEditController,
            style: TextStyle( fontSize: 18.sp),
            cursorColor: Colors.white,
            onChanged: (text){
              setState(() {

              });
            },
          ),
        ),
      ),
    );

    var _loginButton = SizedBox(
      child: CupertinoButton(
          child: Text("sign in", style: TextStyle( fontSize: 20.sp)),
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5),
          onPressed: (){

            if(_idTextEditController.text.isNotEmpty && _passwordEditController.text.isNotEmpty)
            {
              loginUser(_idTextEditController.text,_passwordEditController.text);
            }
          }

      ),
    );
    return Scaffold(
      //bottom overflow 없애기 위해서
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 100.h,),
              Image.asset('assets/images/logo4.png', width: 200.w,height: 200.h,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 37.w),
                    child: Text(
                        "Login to your Account",
                        style: TextStyle(
                            color:  const Color(0xff000000),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Sarabun",
                            fontStyle:  FontStyle.normal,
                            fontSize: 22.sp
                        ),
                        textAlign: TextAlign.left
                    ),
                  ),
                  SizedBox(height: 30.h,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _idTextField),
                  SizedBox(height: 5.h,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _passwordTextField),
                  SizedBox(height: 50.h,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _loginButton),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color:  Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Sarabun",
                          fontStyle:  FontStyle.normal,
                          fontSize: 18.sp
                      ),
                      textAlign: TextAlign.left
                  ),
                  SizedBox(width: 5.w,),
                  GestureDetector(
                    onTap: (){
                      Get.to(SignupScreen());
                    },
                    child: Text(
                        "Sign up",
                        style: TextStyle(
                            color:  Theme.of(context).accentColor,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Sarabun",
                            fontStyle:  FontStyle.normal,
                            fontSize: 18.sp
                        ),
                        textAlign: TextAlign.left
                    ),
                  ),
                ],
              )



            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idTextEditController.dispose();
    _passwordEditController.dispose();
    super.dispose();
  }
  Future loginUser(String id, String password) async{

    var res = await http.post(
      Uri.parse('http://192.168.45.16:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email':id,
        'password':password,
      }),
    );

    if(res.statusCode==302){
      print(res.statusCode);
      print(res.body);
      print("로그인 성공");
      Get.snackbar('로그인', '로그인 성공!', backgroundColor: Colors.white);
      //모든 페이지 스택 삭제하고 페이지 이동
      Get.offAll(MyHomePage(), arguments: 'pass');
      // shared preferences 얻기
      final prefs = await SharedPreferences.getInstance();
      var array=[id,password];
      // 값 저장하기
      prefs.setStringList('info',array);

    }

    else {
      print('로그인 실패');
      Get.snackbar('로그인', res.body);
      throw Exception('로그인 실패');

    }
  }
}