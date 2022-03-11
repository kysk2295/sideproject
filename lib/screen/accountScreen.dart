import 'dart:convert';

import 'package:ex0205/model/user.dart';
import 'package:ex0205/screen/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:http/http.dart' as http;


class AccountScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountScreenState();
  }

}

class _AccountScreenState extends State<AccountScreen> {

  var _accountList =['NH농협', 'KB국민','카카오뱅크','신한','우리','IBK기업','하나','새마을'
  ,'대구','부산','케이뱅크','우체국','신협','SC제일','경남','수협','광주','전북','토스뱅크','저축은행','중국공상'
  ,'JP모간','BNP파리바','씨티','제주','KDB산업','SBI저축은행','산림조합','BOA','HSBC','중국'
  ,'도이치','중국건설'];

  String? _bankName;
  final _nameEditController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final _searchController = TextEditingController();
  late FocusNode myFocusNode;


  @override
  void initState() {
    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var _loginButton = SizedBox(
      child: CupertinoButton(
          child: Text("Sign up", style: TextStyle( fontSize: 20.sp)),
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5),
          onPressed: (){
            createUser(_nameEditController.text.trim(), _bankName);
          }

      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 100.h,),
              Center(child: Image.asset('assets/images/logo4.png', width: 200.w,height: 200.h,)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                        "Optional",
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

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Text("Select a Bank", style:
                    TextStyle(
                        fontSize: 13.sp,
                        color: Colors.blueGrey
                    ),),),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0,10)
                            )
                          ]
                      ),
                      child: SearchField(
                        hint: 'Search',
                        searchInputDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey.shade200,
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder:  OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue.withOpacity(0.8),
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),

                        ),
                        itemHeight: 50.h,
                        maxSuggestionsInViewPort: 6,
                        suggestionsDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        onTap: (value){
                          setState(() {
                            _bankName=value.item.toString();

                          });
                        },
                        suggestions: _accountList.map((value) => SearchFieldListItem(value,item: value)).toList(),
                        controller: _searchController,
                      )
                  ),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Text("Write a Bank Account", style:
                    TextStyle(
                        fontSize: 13.sp,
                        color: Colors.blueGrey
                    ),),),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0,10)
                          )
                        ]
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey.shade200,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue.withOpacity(0.8),
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: 'Write',
                      ),
                      minLines: 1,
                      keyboardType: TextInputType.number,
                      controller: _nameEditController,

                    ),
                  ),
                  SizedBox(height: 50.h,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _loginButton),
                    ],
                  )
                ],
              )






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
}
Future createUser(String? account, String? bankName) async {
  var res = await http.post(
    Uri.parse('http://192.168.45.52:3000/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String?>{
      'name': (Get.arguments as User).name,
      'email':(Get.arguments as User).email,
      'password':(Get.arguments as User).password,
      'account':account,
      'bankType':bankName,
    }),
  );

  if(res.statusCode ==302) {
    print("회원가입 success");
    Get.snackbar('회원가입', '회원가입이 성공적으로 완료되었습니다!');
    Get.off(LoginScreen());
  }

  else {
    print("fail to connect server");
    Get.snackbar('회원가입', '이메일이 중복되었습니다!');

  }


  print(res.body);
}