import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:easycare/util/imagebutton.dart';

import '../app/modules/login/controllers/login_controller.dart';
import 'color.dart';
import 'image.dart';

class MyTodo extends StatefulWidget {
  // 传入参数
  const MyTodo({
    Key? key,
    required this.onEdit,
    required this.onDel,
    required this.onRun,
    required this.onDone,
    required this.onReset,
    required this.data,

  }) : super(key: key,);
  final Map data;
  final VoidCallback onDel;
  final VoidCallback onEdit;
  final VoidCallback onRun;
  final VoidCallback onDone;
  final VoidCallback onReset;

  @override
  State<StatefulWidget> createState() => MyTodoState();

}

class MyTodoState extends State<MyTodo> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, left: 12, top: 5, bottom: 5,),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(24, 5, 0, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Text(widget.data['name'],style: TextStyle(fontSize:16.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value))),
                      Text.rich(
                          TextSpan(
                              children: [
                                TextSpan( text: widget.data['desc'],style: const TextStyle(fontSize:13.0,fontWeight:FontWeight.w400,color: Colors.black54),),
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 25, 0),
                          child: Text(widget.data['beginDate'] + ' ~ ' + widget.data['endDate'],style: const TextStyle(color: Colors.black26,fontSize: 10),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: const EdgeInsets.fromLTRB(15, 5, 3, 5),
                  child: MyImgButton(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    radius:3,
                    imgPath: widget.data['status'] == 'wait'?'assets/images/system/run.png':widget.data['status'] == 'start'?'assets/images/system/done.png':widget.data['status'] == 'end'?'assets/images/system/reset.png':'',
                    text: '',
                    width: 35,
                    height: 35,
                    onTap: () {
                      if (widget.data['status'] == 'wait') {
                        widget.onRun();
                      } else if (widget.data['status'] == 'start') {
                        widget.onDone();
                      } else if (widget.data['status'] == 'end') {
                        widget.onReset();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 10,
            top: 8,
            child: Container(
              // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              padding: const EdgeInsets.fromLTRB(2, 15, 2, 15),
              decoration: BoxDecoration(color: widget.data['tagId'] == 2 ?Colors.redAccent:widget.data['tagId'] == 1?Colors.orangeAccent:widget.data['tagId'] == 0?Colors.greenAccent:ColorUtil.fromHex(LoginController.setColor.value),)
            ),
          ),
          Positioned(
            bottom: 4,
            left: 20 ,
            child: Container(
              child: InkWell(               // 添加点击事件
                child: Text(
                    widget.data['status'] == 'wait'?'待处理':widget.data['status'] == 'start'?'已开始':widget.data['status'] == 'end'?'已完成':'',
                    style: TextStyle(
                        color: widget.data['status'] == 'wait'?Colors.deepOrange:widget.data['status'] == 'start'?Colors.green:widget.data['status'] == 'end'?Colors.blueGrey:ColorUtil.fromHex(LoginController.setColor.value),
                        fontSize: 10),
                ),
                onTap: (){},
              ),

            ),
          ),
          Positioned(
            bottom: 4,
            right: MediaQuery.of(context).size.width * 0.2 ,
            child: Container(
              // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              // padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
              // decoration: BoxDecoration(color: ColorUtil.fromHex(LoginController.setColor.value),),
              child:  InkWell(               // 添加点击事件
                child: Text('Edit',style: TextStyle(color: ColorUtil.fromHex(LoginController.setColor.value),fontSize: 12),),
                onTap: (){widget.onEdit();},
              ),

            ),
          ),
          Positioned(
            bottom: 4,
            right: MediaQuery.of(context).size.width * 0.1 ,
            child: Container(
              // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              // padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
              // decoration: BoxDecoration(color: ColorUtil.fromHex(LoginController.setColor.value),),
              child: InkWell(               // 添加点击事件
                child: Text('Del',style: TextStyle(color: ColorUtil.fromHex(LoginController.setColor.value),fontSize: 12),),
                onTap: (){widget.onDel();},
              ),

            ),
          )

        ],
      ),
    );
  }

}