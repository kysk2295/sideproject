import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:blur/blur.dart';
import 'package:ex0205/bottomBlurController.dart';
import 'package:ex0205/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }

}

//animation provider 제공하기 위해 with ~~라 붙임
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  //bool _selected = false;
  final controller = Get.put(BottomBlurController());

  late Animation<double> animation;
  late AnimationController animationController;
  late bool value;
  late double widthVlaue;
  var category_text;

  late TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,
    duration: Duration(milliseconds: 300));
    setRotation(180);
    category_text='ALL';
    _editingController = TextEditingController(text: 'SEARCH');
    value = false;
    widthVlaue = 20.w;
    data = loadData();

  }
  void setRotation(int degrees) {
    final angle = degrees * pi / 180;
    animation = Tween<double>(begin: 0,end: angle).animate(animationController);
  }


  @override
  void dispose() {
    animationController.dispose();
    _editingController.dispose();
    super.dispose();
  }

  late Future<List<dynamic>> data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // floatingActionButton: (!controller.selected || controller.searchselected) ? FloatingActionButton(backgroundColor: Theme.of(context).accentColor,
      // onPressed: () {  },
      // child: Icon(Icons.add, color: Colors.white,),) :
      // null,
      floatingActionButton: getButton(),
      body: Column(
        children: [
          AnimatedContainer(
            height: getContainerHeight(),
            curve: Curves.easeIn,
            margin: EdgeInsets.only(top: 50.h),
            padding: !controller.searchselected ? EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0) : EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0),
            duration: const Duration(milliseconds: 300),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: !controller.searchselected ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    InkWell(
                      onTap: (){
                        setState(() {
                          //_selected=!_selected;
                          //print(_selected);
                          controller.changeState();
                          if(controller.selected)
                            animationController.forward(from: 0);
                          else
                            {
                              animationController.reverse();
                            }

                          print(controller.selected);
                        });
                      },
                      child: !controller.searchselected ? Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            category_text,
                            style: TextStyle(
                              color:  const Color(0xffffffff),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Sarabun",
                              fontStyle:  FontStyle.normal,

                            ),
                          ),
                          SizedBox(width: 5.w,),
                          AnimatedBuilder(
                            animation: animation,
                            child: Container(//margin: EdgeInsets.fromLTRB(13.w, 6.h, 0, 0),
                                child: Image.asset('assets/images/all.png', width: 13.w, height: 13.h,)),
                            builder: (_,child) =>
                            Transform.rotate(
                              angle: animation.value,
                              child: child
                            ),
                          ),

                          // SizedBox(
                          //   child: IconButton(onPressed: (){
                          //     setState(() {
                          //       _selected=!_selected;
                          //     });
                          //   }, icon: Image.asset('assets/images/all.png', width: 13.w, height: 13.h, ),
                          //   padding: EdgeInsets.fromLTRB(0,5.h,20.w,0),),
                          // ),

                        ],
                      ) :Row(
                        mainAxisSize: MainAxisSize.max,
                        children :[
                          AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: widthVlaue,
                          alignment: Alignment.topCenter,
                          curve: Curves.easeOutQuint,
                          child:
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  suffixIconConstraints: BoxConstraints(
                                      minHeight: 14.h,
                                      minWidth: 14.w
                                  ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ), hintText: 'SEARCH',fillColor: Colors.white,
                                hintStyle: TextStyle(
                                        color:  const Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Sarabun",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 16.sp
                                    ),

                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                suffixIcon:InkWell(onTap: (){
                                  setState(() {
                                    //만약에 all 버튼을 누른 상태에서 검색바를 누르면 이렇게 됨
                                    if(controller.selected && controller.searchselected == true){
                                    setState(() {
                                      controller.changeState();
                                      animationController.reverse();
                                    });

                                    }
                                    controller.changeState2();
                                    widthVlaue=20.w;

                                  });

                                  //controller.changeNothing();
                                  print(controller.searchselected);
                                  print(controller.selected);
                                },
                                    child: Image.asset('assets/images/search.png', width: 18.w, height: 18.h, )),
                              ),

                             // controller: _editingController,
                            ),
                          ),


                        ),
        ]
                      ),
                    ),
                    Row(
                      children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            controller.changeState2();
                            Future.delayed(Duration(milliseconds: 100) , (){
                              setState(() {
                                widthVlaue=368.w;
                              });

                            });
                          });

                        }
                          ,child: !controller.searchselected ? Image.asset('assets/images/search.png', width: 18.w, height: 18.h, ) : SizedBox()) ,
                        SizedBox(width: 20.w,),
                        !controller.searchselected ? Image.asset('assets/images/profile.png', width: 20.w, height: 20.h,color: Colors.white, ) :SizedBox()
                      ],
                    )

                  ],
                ),
                  getWidget()


        ]
              ),
            ),

          ),

          Expanded(
            child: ( controller.selected || controller.searchselected) ? Blur(
              blur: 20,
              blurColor: Theme.of(context).primaryColor,
              child: FutureBuilder(
                future: data,
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot){

                  if(snapshot.connectionState == ConnectionState.done)
                    {
                      print("1");
                      if(snapshot.hasData)
                        {
                          print("1");
                          return productGridview(data: snapshot.data??[]);
                        }
                      else
                        {
                          print("2");
                          return CircularProgressIndicator();
                        }
                    }else
                      {
                        print("3");
                        return CircularProgressIndicator();
                      }
                  },
                  )
            ) : FutureBuilder(
              future: data,
              builder: (context,AsyncSnapshot<List<dynamic>> snapshot){

                if(snapshot.connectionState == ConnectionState.done)
                {
                  print("1");
                  if(snapshot.hasData)
                  {
                    print("1");
                    return productGridview(data: snapshot.data??[]);
                  }
                  else
                  {
                    print("2");
                    return CircularProgressIndicator();
                  }
                }else
                {
                  print("3");
                  return CircularProgressIndicator();
                }
              },
            )
          ),
        ],

      ),
    );

  }

  Future<List<dynamic>> loadData() async{

      var res = await http.post(
        Uri.parse('http://192.168.45.52:3000/home'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).catchError((error){
        print(error);
      });
      print(json.decode(res.body));

      return json.decode(res.body);
  }




  FloatingActionButton? getButton() {
    if(controller.selected)
      {
      return null;
  }
    else if(controller.searchselected)
      {
        return null;
      }
    else {
      return  FloatingActionButton(backgroundColor: Theme.of(context).accentColor,
          onPressed: () {  },
          child: Icon(Icons.add, color: Colors.white,));
    }
  }

   double getContainerHeight() {
     if(controller.selected)
       {
          return 180.h;
       }
     else if(controller.searchselected) {
       return 180.h;
     }
     else {
      return 76.h;
     }

       }


  bool getBool() {
    if(controller.selected && controller.searchselected == false)
      return false;

    else
      return true;

  }

  Widget getWidget() {
    if(controller.selected)
      {
        if(controller.searchselected)
          return  Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h,),
                Text(
                    "keyword",
                    style:  TextStyle(
                        color:  const Color(0xffffffff),
                        fontWeight: FontWeight.w300,
                        fontFamily: "Sarabun",
                        fontStyle:  FontStyle.normal,
                        fontSize: 16.sp
                    ),
                    textAlign: TextAlign.left
                ),
                SizedBox(height: 8.h,),
                Text(
                    "keyword",
                    style:  TextStyle(
                        color:  const Color(0xffffffff),
                        fontWeight: FontWeight.w300,
                        fontFamily: "Sarabun",
                        fontStyle:  FontStyle.normal,
                        fontSize: 16.sp
                    ),
                    textAlign: TextAlign.left
                ),
                SizedBox(height: 8.h,),
                Text(
                    "keyword",
                    style: TextStyle(
                        color:  const Color(0xffffffff),
                        fontWeight: FontWeight.w300,
                        fontFamily: "Sarabun",
                        fontStyle:  FontStyle.normal,
                        fontSize: 16.sp
                    ),
                    textAlign: TextAlign.left
                ),
              ],
            ),
          );
        else
          return Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h,),
                InkWell(
                  onTap: (){
                    setState(() {
                      category_text = "ALL";
                      controller.changeState();
                      animationController.reverse();
                    });
                  },
                  child: Text(
                      "ALL",
                      style:  TextStyle(
                          color:  const Color(0xffffffff),
                          fontWeight: FontWeight.w300,
                          fontFamily: "Sarabun",
                          fontStyle:  FontStyle.normal,
                          fontSize: 15.sp
                      ),
                      textAlign: TextAlign.left
                  ),
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    setState(() {
                      category_text ="RELEASED AVAILABLE";
                      controller.changeState();
                      animationController.reverse();
                    });
                  },
                  child: Text(
                      "RELEASED AVAILABLE",
                      style:  TextStyle(
                          color:  const Color(0xffffffff),
                          fontWeight: FontWeight.w300,
                          fontFamily: "Sarabun",
                          fontStyle:  FontStyle.normal,
                          fontSize: 15.sp
                      ),
                      textAlign: TextAlign.left
                  ),
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    setState(() {
                      category_text = "TAG - MOVIE";
                      controller.changeState();
                      animationController.reverse();
                    });
                  },
                  child: Text(
                      "TAG - MOVIE",
                      style:  TextStyle(
                          color:  const Color(0xffffffff),
                          fontWeight: FontWeight.w300,
                          fontFamily: "Sarabun",
                          fontStyle:  FontStyle.normal,
                          fontSize: 15.sp
                      ),
                      textAlign: TextAlign.left
                  ),
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    setState(() {
                      category_text="TAG - GAME";
                      controller.changeState();
                      animationController.reverse();
                    });
                  },
                  child: Text(
                      "TAG - GAME",
                      style:  TextStyle(
                          color:  const Color(0xffffffff),
                          fontWeight: FontWeight.w300,
                          fontFamily: "Sarabun",
                          fontStyle:  FontStyle.normal,
                          fontSize: 15.sp
                      ),
                      textAlign: TextAlign.left
                  ),
                )
              ],
            ),
          );
      }
    if(controller.selected && controller.searchselected)
    {
      return  Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h,),
            Text(
                "keyword",
                style:  TextStyle(
                    color:  const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Sarabun",
                    fontStyle:  FontStyle.normal,
                    fontSize: 16.sp
                ),
                textAlign: TextAlign.left
            ),
            SizedBox(height: 8.h,),
            Text(
                "keyword",
                style:  TextStyle(
                    color:  const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Sarabun",
                    fontStyle:  FontStyle.normal,
                    fontSize: 16.sp
                ),
                textAlign: TextAlign.left
            ),
            SizedBox(height: 8.h,),
            Text(
                "keyword",
                style: TextStyle(
                    color:  const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Sarabun",
                    fontStyle:  FontStyle.normal,
                    fontSize: 16.sp
                ),
                textAlign: TextAlign.left
            ),
          ],
        ),
      );
    }
    else if(controller.searchselected)
      {
        print('검색아이콘 선택됨');
        return  Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h,),
              Text(
                  "keyword",
                  style:  TextStyle(
                      color:  const Color(0xffffffff),
                      fontWeight: FontWeight.w300,
                      fontFamily: "Sarabun",
                      fontStyle:  FontStyle.normal,
                      fontSize: 16.sp
                  ),
                  textAlign: TextAlign.left
              ),
              SizedBox(height: 8.h,),
              Text(
                  "keyword",
                  style:  TextStyle(
                      color:  const Color(0xffffffff),
                      fontWeight: FontWeight.w300,
                      fontFamily: "Sarabun",
                      fontStyle:  FontStyle.normal,
                      fontSize: 16.sp
                  ),
                  textAlign: TextAlign.left
              ),
              SizedBox(height: 8.h,),
              Text(
                  "keyword",
                  style: TextStyle(
                      color:  const Color(0xffffffff),
                      fontWeight: FontWeight.w300,
                      fontFamily: "Sarabun",
                      fontStyle:  FontStyle.normal,
                      fontSize: 16.sp
                  ),
                  textAlign: TextAlign.left
              ),
            ],
          ),
        );
      }

    else
      return Container();


  }

}