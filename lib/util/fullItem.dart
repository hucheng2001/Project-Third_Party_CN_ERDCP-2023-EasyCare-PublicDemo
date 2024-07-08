import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:easycare/util/toast.dart';
import 'full.dart';

class MyFullButtonItem extends StatefulWidget {
  // 传入参数
  const MyFullButtonItem({
    Key? key,
    required this.dataForm,
  }) : super(key: key,);
  final List dataForm;
  @override
  State<StatefulWidget> createState() => MyFullButtonItemState();
}

class MyFullButtonItemState extends State<MyFullButtonItem> {
  _makeList() {
    List<Widget> theList = [];
    theList = [];
    for (var i = 0; i < widget.dataForm.length; i++) {
      theList.add(
          FullButton(
            iconPath: widget.dataForm[i]['iconPath'],
            title: widget.dataForm[i]['title'],
            showDivider: i == widget.dataForm.length-1 ? false : true,
            onPressed: () async {
              if (widget.dataForm[i]['path'] == ''){
                MyToast.danger('待开发');
              } else {
                Get.toNamed(widget.dataForm[i]['path'], arguments: '');
              }
            },
          )
      );
    }
    return theList;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _makeList(),
    );
  }

}