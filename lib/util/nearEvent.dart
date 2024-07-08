import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app/modules/login/controllers/login_controller.dart';
import 'color.dart';
import 'image.dart';

class MyNearEvent extends StatefulWidget {
  // 传入参数
  const MyNearEvent({
    Key? key,
    required this.onEdit,
    required this.onDel,
    required this.data,

  }) : super(key: key,);
  final Map data;
  final VoidCallback onDel;
  final VoidCallback onEdit;

  @override
  State<StatefulWidget> createState() => MyNearEventState();

}

class MyNearEventState extends State<MyNearEvent> {

  deffTime(String date){
    if (date != ''){
      date = DateFormat('yyyy-MM-dd').format(DateTime.now()).substring(0, 4) + date.substring(4);
      var startDate = DateFormat('yyyy-MM-dd').parse(date);
      var endDate = DateTime.now();
      int deffday = startDate.difference(endDate).inDays + 1;
      return deffday.toString();
    } else {
      return '0';
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5,),
      child: Stack(
        children: [
          widget.data['pic'] != ''?Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Text(widget.data['date']),
                      Text.rich(
                          TextSpan(
                              children: [
                                const TextSpan( text: '还有',style: TextStyle(fontSize:10.0)),
                              ]
                          )
                      ),
                      Center(
                        child: Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan( text: ' ' + widget.data['date'] != ''?deffTime(widget.data['date']):'0' + ' ',style: TextStyle(fontSize:18.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                                  const TextSpan( text: ' 天',style: TextStyle(fontSize:10.0)),
                                ]
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (ctx, animation, animation2) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ImageDetail(widget.data['pic']),
                                );
                              }));
                        },
                        child: Center(
                          child: Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  File(widget.data['pic'],),
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(0),
                              border: Border.all(color: Colors.white, width: 0.1),// border
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          padding: const EdgeInsets.fromLTRB(4, 2, 4, 3),
                          decoration: BoxDecoration(color: ColorUtil.fromHex(LoginController.setColor.value),borderRadius: BorderRadius.all(Radius.circular(3)),),
                          child: Text(widget.data['typ'],style: TextStyle(color: Colors.white,fontSize: 10),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Text(widget.data['name'],style: TextStyle(fontSize:15.0,fontWeight:FontWeight.w600,)),
                      Text(widget.data['desc'],style: TextStyle(fontSize:15.0,fontWeight:FontWeight.w400,color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ],
          ):Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Text(widget.data['date']),
                      Text.rich(
                          TextSpan(
                              children: [
                                const TextSpan( text: '还有',style: TextStyle(fontSize:10.0)),
                              ]
                          )
                      ),
                      Center(
                        child: Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan( text: ' ' + widget.data['date'] != ''?deffTime(widget.data['date']):'0' + ' ',style: TextStyle(fontSize:18.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                                  const TextSpan( text: ' 天',style: TextStyle(fontSize:10.0)),
                                ]
                            )
                        ),
                      )

                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Text(widget.data['name'],style: TextStyle(fontSize:15.0,fontWeight:FontWeight.w600)),
                      Text(widget.data['desc'],style: TextStyle(fontSize:15.0,fontWeight:FontWeight.w400,color: Colors.black54)),
                      SizedBox(height: 5,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 3),
                            decoration: BoxDecoration(color: ColorUtil.fromHex(LoginController.setColor.value),borderRadius: const BorderRadius.all(Radius.circular(3)),),
                            child: Text(widget.data['typ'],style: const TextStyle(color: Colors.white,fontSize: 10),),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //   bottom: 0,
          //   right: MediaQuery.of(context).size.width * 0.2 ,
          //   child: Container(
          //     // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          //     // padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          //     // decoration: BoxDecoration(color: ColorUtil.fromHex(LoginController.setColor.value),),
          //       child:  InkWell(               // 添加点击事件
          //         child: Text('Edit',style: TextStyle(color: ColorUtil.fromHex(LoginController.setColor.value),),),
          //         onTap: (){widget.onEdit();},
          //       ),
          //
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   right: MediaQuery.of(context).size.width * 0.1 ,
          //   child: Container(
          //     // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          //     // padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          //     // decoration: BoxDecoration(color: ColorUtil.fromHex(LoginController.setColor.value),),
          //       child: InkWell(               // 添加点击事件
          //         child: Text('Del',style: TextStyle(color: ColorUtil.fromHex(LoginController.setColor.value),),),
          //         onTap: (){widget.onDel();},
          //       ),
          //
          //   ),
          // )
        ],
      ),
    );
  }

}