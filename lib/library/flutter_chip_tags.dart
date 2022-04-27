library flutter_chip_tags;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class ChipTags extends StatefulWidget {
  ///sets the remove icon Color
  final Color iconColor;

  ///sets the chip background color
  final Color chipColor;

  ///sets the color of text inside chip
  final Color textColor;

  ///container decoration
  final InputDecoration decoration;

  ///set keyboradType
  final TextInputType keyboardType;

  ///customer symbol to seprate tags by default
  ///it is " " space.
  final String separator;

  /// list of String to display
  final List<String> list;
  const ChipTags({
    Key ?key,
    required this.iconColor,
    required this.chipColor,
    required this.textColor,
    required this.decoration,
    required this.keyboardType,
    required this.separator,
    required this.list,
  }) : super(key: key);
  @override
  _ChipTagsState createState() => _ChipTagsState();
}

class _ChipTagsState extends State<ChipTags>
    with SingleTickerProviderStateMixin {
  ///Form key for TextField
  final _formKey = GlobalKey<FormState>();
  TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xffecebeb),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: TextField(
              controller: _inputController,
              decoration: widget.decoration,

              keyboardType: widget.keyboardType,
              onChanged: (value) {
                ///check if user has send " " so that it can break the line
                ///and add that word to list
                if (value.endsWith(widget.separator)) {
                  ///check for ' ' and duplicate tags
                  if (value != ' ' && !widget.list.contains(value.trim())) {
                    widget.list
                        .add(value.replaceFirst(widget.separator, '').trim());
                  }

                  ///setting the controller to empty
                  _inputController.clear();

                  ///resetting form
                  _formKey.currentState?.reset();

                  ///refersing the state to show new data
                  setState(() {});
                }
              },
            ),
          ),
        ),
        SizedBox(height: 10.h,),
        Visibility(
          //if length is 0 it will not occupie any space
          visible: widget.list.length > 0,
          //크기가 디바이스를 벗어났을때 줄내림을 해줄때 사용
          child: Wrap(
            runSpacing: 5.h,
            ///creating a list
            children: widget.list.map((text) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.h),
              child: Material(
              color: widget.chipColor,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(text, style: TextStyle(color: widget.textColor),),
                      Icon(Icons.close, color: widget.iconColor, size: 16.w,),

                    ],
                  ),
                ),
                onTap: (){
          widget.list.remove(text);
          setState(() {
          });
    }

              ),
              ));
            }).toList(),
          ),
        ),
      ],
    );
  }
}