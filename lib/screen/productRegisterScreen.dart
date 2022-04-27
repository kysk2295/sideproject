
import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../library/flutter_chip_tags.dart';

class ProductRegisterScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductRegisterScreenState();
  }

}

class _ProductRegisterScreenState extends State<ProductRegisterScreen> {

  List<String> tagsList = ['apple', 'banana', 'orange', 'kiwi', ''];
  List<String> selectedTags = [];

  List<String> _myList =[];
  int tag = 1;

  // multiple choice value
  List<String> tags = [];

  // list of string options
  List<String> options = [
    'News', 'Entertainment', 'Politics',
    'Automotive', 'Sports', 'Education',
    'Fashion', 'Travel', 'Food', 'Tech',
  ];

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles=[];

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _glbController = TextEditingController();
  final _priceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "상품 등록",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontFamily: "Noto Sans KR",
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
          ),
          leading: IconButton(icon: Icon(Icons.clear, color: Colors.black,), onPressed: (){
            Get.back();
          },),
          actions: [
            IconButton(onPressed: (){
              //모든 항목이 채워져 있을 때
              if(_titleController.text.isNotEmpty && _descController.text.isNotEmpty && _glbController.text.isNotEmpty &&_priceController.text.isNotEmpty)
                {

                }
              else {
                if(_titleController.text.isEmpty)
                  Get.snackbar('상품등록 실패', '타이틀을 입력해주세요!');
                else if(_descController.text.isEmpty)
                  Get.snackbar('상품등록 실패', '내용을 입력해주세요!');
                else if(_glbController.text.isEmpty)
                  Get.snackbar('상품등록 실패', 'glb링크를 입력해주세요!');
                else if(_priceController.text.isEmpty)
                  Get.snackbar('상품등록 실패', '가격을 입력해주세요!');
              }
            }, icon: Icon(Icons.check, color: Colors.black,))
          ],
        ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h,),
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: InkWell(
                    onTap: () async {
                      try {
                        var pickedfiles = await imgpicker.pickMultiImage();
                        //you can use ImageCourse.camera for Camera capture
                        if(pickedfiles != null){
                          imagefiles = pickedfiles;
                          setState(() {
                          });
                        }else{
                          print("No image is selected.");
                        }
                      }catch (e) {
                        print("error while picking file.");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      width: MediaQuery.of(context).size.width,
                      height: 220.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffecebeb),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 42.w,height: 42.h,
                    child: Image.asset('assets/images/_plus.png'))

              ],
            ),

            Visibility(visible: imagefiles!.isNotEmpty,child: SizedBox(height: 15.h,)),
            Visibility(
              visible: imagefiles!.isNotEmpty,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Text(
                      "Images",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        letterSpacing: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(visible: imagefiles!.isNotEmpty,child: SizedBox(height: 15.h,)),
            Visibility(
              visible: imagefiles!.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: GridView.builder(
                    itemCount: imagefiles!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(File(imagefiles![index].path),
                        fit: BoxFit.cover,);
                    }),
              ),
            ),

            SizedBox(height: 25.h,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    "Title",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffecebeb),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                controller: _titleController,
              ),
            ),
            SizedBox(height: 25.h,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    "Description",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              padding: EdgeInsets.fromLTRB(10.w,5.h,10.w,5.h),
              width: MediaQuery.of(context).size.width,
              height: 190.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffecebeb),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                controller: _descController,
                maxLines: 10,
              ),
            ),
            SizedBox(height: 25.h,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    "Category",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ],
            ),
             Container(
               margin: EdgeInsets.symmetric(horizontal: 10.w),
               child: ChipsChoice<int>.single(
                  value: tag,
                  onChanged: (val) => setState(() => tag = val),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: options,
                    value: (i, v) => i,
                    label: (i, v) => v,
                    tooltip: (i, v) => v,
                  ),
                  choiceStyle: C2ChoiceStyle(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    showCheckmark: false,
                    color: Color(0xffc4c4c4),
                    labelStyle: TextStyle(color:Colors.black),
                    brightness: Brightness.dark
                  ),
                  choiceActiveStyle: C2ChoiceStyle(
                    color: Colors.red,
                    labelStyle: TextStyle(color: Colors.white)
                  ),


                ),
             ),

            SizedBox(height: 25.h,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    "GLB link",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffecebeb),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,

                ),
                controller: _glbController,
              ),
            ),
            SizedBox(height: 25.h,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    "Tags",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),

        Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: ChipTags(
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
                chipColor: Colors.red,
                iconColor: Colors.white,
                textColor: Colors.white,
                list: _myList,
                separator: " ",
                keyboardType: TextInputType.text,

              ),
            ),

            SizedBox(height: 25.h,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    "Price",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffecebeb),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    textAlign: TextAlign.right,
                    controller: _priceController,
                ),
                    flex: 15,
                  ),
                  Flexible(child: Text("\$") ,flex: 1,)
        ]
              ),
            ),
            SizedBox(height: 50.h,)

          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

  }
}
// final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
// // Allows you to get a list of all the ItemTags
// _getAllItem(){
//   List<Item>? lst = _tagStateKey.currentState?.getAllItem;
//   if(lst!=null)
//     lst.where((a) => a.active==true).forEach( ( a) => print(a.title));
// }

