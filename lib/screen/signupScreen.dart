import 'package:ex0205/model/user.dart';
import 'package:ex0205/screen/accountScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SignupScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpScreenState();
  }

}

class _SignUpScreenState extends State<SignupScreen>{

  final _idTextEditController = TextEditingController();
  final _passwordEditController = TextEditingController();
  final _nameEditController = TextEditingController();
  late User user;

  var _flag=false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setState(() {
      if(_nameEditController.text.isNotEmpty && _idTextEditController.text.isNotEmpty && _passwordEditController.text.isNotEmpty ){
        if(_idTextEditController.text.toString().trim().length>=6 && _passwordEditController.text.toString().trim().length>=6) {
          user = User(name:
              _nameEditController.text.trim(),
              email: _idTextEditController.text.trim(),
              password: _passwordEditController.text.trim(),
              bankType: '', account: '');
          _flag=true;
        }
        else {
          _flag=false;
        }
      }
      else {
        _flag=false;
      }
    });


    var _nameTextField = Container(
      height: 65.h,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Name',
              border: InputBorder.none,
            ),
            controller: _nameEditController,
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
          child: Text("Next", style: TextStyle( fontSize: 20.sp)),
          color: _flag ? Theme.of(context).accentColor:Color(0xffcccccc),
          borderRadius: BorderRadius.circular(5),
          onPressed: _flag ? (){

            Get.to(AccountScreen(), arguments: user);

          }:null
      ),
    );
    return Scaffold(
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
                        "Create your Account",
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
                  Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _nameTextField),
                  SizedBox(height: 5.h,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _idTextField),
                  SizedBox(height: 5.h,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _passwordTextField),
                  SizedBox(height: 50.h,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _loginButton),

                ],
              ),




            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 50.w,
        height: 50.h,
        child: FloatingActionButton(onPressed: (){
          Get.back();
        },
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

    );
  }

  @override
  void dispose() {
    _idTextEditController.dispose();
    _passwordEditController.dispose();
    _nameEditController.dispose();
    super.dispose();
  }
}