import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscribeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SubscribeScreenState();
  }

}

class _SubscribeScreenState extends State<SubscribeScreen> {

  final List<String> entries=['Artist1', 'Artist2', 'Artist3', 'Artist4',
  'Artist5', 'Artist6', 'Artist7', 'Artist8', 'Artist9', 'Artist10'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 74.h,
              margin: EdgeInsets.only(top: 53.h, left: 15.w),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: entries.length,
                shrinkWrap: true,
                itemBuilder: (_,index){
                  return Container(
                    margin: EdgeInsets.only(right: 27.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: const Color(0xffb7b7b7),
                              shape: BoxShape.circle
                            )
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                            entries[index],
                            style:  TextStyle(
                                color:  const Color(0xffffffff),
                                fontWeight: FontWeight.w300,
                                fontFamily: "Sarabun",
                                fontStyle:  FontStyle.normal,
                                fontSize: 11.sp
                            ),
                            textAlign: TextAlign.left
                        )
                      ],
                    ),
                  );
                },


              ),
            ),
            SizedBox(height: 13.h,),

            ListView.builder(itemCount: entries.length,
            scrollDirection: Axis.vertical,
              shrinkWrap: true,
             primary: false,
             itemBuilder: (_,index){
              return Container(
                    height: 317.h,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1
                      ,child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 1.h,)
                          ,Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "Product \n Name",
                                  style: TextStyle(
                                      color:  const Color(0xffffffff),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Sarabun",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 15.sp
                                  ),
                                  textAlign: TextAlign.center
                              ),
                              Text(
                                "by",
                                style:  TextStyle(
                                    color:  const Color(0xffffffff),
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Sarabun",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 12.sp
                                ),
                                textAlign: TextAlign.center
                                ,
                              ),
                              // Artist Name
                              Text(
                                  "Artist Name",
                                  style:  TextStyle(
                                      color:  const Color(0xffffffff),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Sarabun",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 15.sp
                                  ),
                                  textAlign: TextAlign.center
                              ),

                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal:25.w, vertical: 0 ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Details
                                    Text(
                                        "Details",
                                        style:  TextStyle(
                                            color:  const Color(0xffffffff),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Sarabun",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 12.sp
                                        ),
                                        textAlign: TextAlign.center
                                    ),
                                    Container(
                                      width: 35.w,
                                      height: 35.h,
                                      child: FloatingActionButton(onPressed: (){}, backgroundColor:
                                      Theme.of(context).accentColor, child:
                                      Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,
                                        size: 15,
                                      ),),
                                    )

                                  ],
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              Container(margin: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Divider(color: Color(0xff343434), thickness: 1.0,
                                  height: 1,)),



                            ],
                          ),


                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                        child: Container(
                          height: 317.h,
                            child: Image.network('https://mambo13004.files.wordpress.com/2021/11/scarlet-spider-9.jpg',
                            fit: BoxFit.cover,)))
                  ],
                ),
              );
             },
            )
          ],
        ),
      ),
    );
  }
}