import 'dart:io';

import 'package:flutter/material.dart';

import 'color.dart';
import 'image.dart';

class MyCard extends StatefulWidget {
  // 传入参数
  const MyCard({
    Key? key,
    required this.onTap,
    required this.onLongPress,
    required this.data,
    this.showOther = false,
    required this.other,

  }) : super(key: key,);
  final Map data;
  final VoidCallback onLongPress;
  final VoidCallback onTap;
  final bool showOther;
  final Widget other;

  @override
  State<StatefulWidget> createState() => MyCardState();

}

class MyCardState extends State<MyCard> {

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10,),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: widget.data['sex']=='woman'?ColorUtil.fromHex('#ffd8f2'):ColorUtil.fromHex('#d8f1ff'),
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (ctx, animation, animation2) {
                              return FadeTransition(
                                opacity: animation,
                                child: ImageDetail(widget.data['portrait']),
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
                                File(widget.data['portrait'],),
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white, width: 2),// border
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {widget.onTap();},
                        onLongPress: () {widget.onLongPress();},
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: widget.data['sex']=='woman'?Icon(Icons.location_history_rounded,color: ColorUtil.fromHex('#e17bbf'),size: 24,):Icon(Icons.location_history_rounded,color: ColorUtil.fromHex('#7dbee3'),size: 24,),
                                      ),
                                      Expanded(
                                        flex: 12,
                                        child: Text(widget.data['name'],style: const TextStyle(color:Colors.black87,fontSize: 12,fontWeight: FontWeight.w600),),
                                      ),
                                    ],
                                  )

                              ),
                              SizedBox(height: 1,),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: widget.data['sex']=='woman'?Icon(Icons.location_on_rounded,color: ColorUtil.fromHex('#e17bbf'),size: 24,):Icon(Icons.location_on_rounded,color: ColorUtil.fromHex('#7dbee3'),size: 24,),
                                      ),
                                      Expanded(
                                        flex: 12,
                                        child: Text(widget.data['site'],style: const TextStyle(color:Colors.black87,fontSize: 12,fontWeight: FontWeight.w600),),
                                      ),

                                    ],
                                  )
                              ),
                              SizedBox(height: 1,),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: widget.data['sex']=='woman'?Icon(Icons.phone,color: ColorUtil.fromHex('#e17bbf'),size: 24,):Icon(Icons.phone,color: ColorUtil.fromHex('#7dbee3'),size: 24,),
                                      ),
                                      Expanded(
                                        flex: 12,
                                        child: Text(widget.data['tel'],style: const TextStyle(color:Colors.black87,fontSize: 12,fontWeight: FontWeight.w600),),
                                      ),
                                    ],
                                  )
                              ),
                              SizedBox(height: 1,),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: widget.data['sex']=='woman'?Icon(Icons.date_range,color: ColorUtil.fromHex('#e17bbf'),size: 24,):Icon(Icons.date_range,color: ColorUtil.fromHex('#7dbee3'),size: 24,),
                                      ),
                                      Expanded(
                                        flex: 12,
                                        child: Text(widget.data['birthday'],style: const TextStyle(color:Colors.black87,fontSize: 12,fontWeight: FontWeight.w600),),
                                      ),
                                    ],
                                  )
                              ),
                              widget.showOther?widget.other:const SizedBox(),
                            ],
                          ),
                        ),
                      )
                  ),

                ],
              ),
              // Column(
              //   children: [Text(widget.data['name'])],
              // ),
          ),
          Positioned(
            right: 1,//左边边距18px
            top:1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(3)),
                color: widget.data['sex']=='woman'?ColorUtil.fromHex('#e17bbf'):ColorUtil.fromHex('#7dbee3'),//Color(0xFFF2F3F7),
              ),
              child: widget.data['sex']=='woman'?Icon(Icons.female,color: Colors.white,):Icon(Icons.male,color: Colors.white,),
            )

          ),
        ],
      )


    );
  }

}