import 'dart:io';

import 'package:flutter/material.dart';

import '../app/modules/login/controllers/login_controller.dart';
import 'color.dart';
import 'image.dart';

class EasyCare extends StatefulWidget {
  // 传入参数
  const EasyCare({
    Key? key,
    this.lineWidth = 0,
    this.lineColor = Colors.black,
    this.backgroundColor = Colors.cyan,
    this.shadowColor = Colors.cyanAccent,
    // this.fontColor = Colors.black,
    required this.data,
    required this.header,
    required this.headerStyle,
    required this.rowStyle,
    required this.onBegin,
    required this.onCreate,
    required this.onEnd,
    required this.onTap,
    required this.onLongPress,
    this.interval = '0',
    this.typ = 'Start',


  }) : super(key: key,);
  final double lineWidth;
  final Color lineColor;
  final Color backgroundColor;
  // final Color fontColor;
  final List data;
  final List header;
  final TextStyle headerStyle;
  final TextStyle rowStyle;
  final Color shadowColor;
  final VoidCallback onBegin;
  final VoidCallback onCreate;
  final VoidCallback onEnd;
  final ValueChanged<Map> onTap;
  final ValueChanged<Map> onLongPress;
  final String interval;
  final String typ;


  @override
  State<StatefulWidget> createState() => MyTableState();

}

class MyTableState extends State<EasyCare> {

  @override
  Widget build(BuildContext context) {
    _getHeader() {
      List<Widget> theList = [];
      for (var i = 0; i < widget.header.length; i++) {
        theList.add(
            TableCell(child: Container(height: 25,child: Center(child: Text(widget.header[i],style: widget.headerStyle,)),))
        );
      }
      return theList;
    }
    _getTableList() {
      List<TableRow> theList = [];
      for (var i = 0; i < widget.data.length; i++) {
        theList.add(
            TableRow(
              decoration: BoxDecoration(color: i%2==0?Colors.white:widget.shadowColor),
              children: [
                TableCell(child: GestureDetector(
                    onTap: () {widget.onTap(widget.data[i]);},
                    onLongPress: () {widget.onLongPress(widget.data[i]);},
                    child: Container(child: Center(child: Text(widget.data[i]['date'],style: widget.rowStyle)),padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),)
                ),),
                TableCell(child: GestureDetector(
                    onTap: () {widget.onTap(widget.data[i]);},
                    onLongPress: () {widget.onLongPress(widget.data[i]);},
                    child:Container(child: Center(child: Text(widget.data[i]['typ']=='start'?'Start':'End',style: widget.rowStyle)),padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),)
                ),),
                TableCell(child: GestureDetector(
                    onTap: () {widget.onTap(widget.data[i]);},
                    onLongPress: () {widget.onLongPress(widget.data[i]);},
                    child:Container(child: Center(child: Text(widget.data[i]['interval'].toString(),style: widget.rowStyle)),padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),)
                ),),
              ],
            )
        );
      }
      return theList;
    }
    _getTableHeader() {
      List<TableRow> theList = [];
      theList.add(
          TableRow(
            decoration: ShapeDecoration(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              color: widget.backgroundColor,
            ),
            children: _getHeader(),
          )
      );
      return theList;
    }
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment:Alignment.center ,
        children: [
          ListView(
            children: [
              const SizedBox(height: 26,),
              Table(
                border: TableBorder.all(
                  color: widget.lineColor,
                  width: widget.lineWidth,
                  style: BorderStyle.none,
                  borderRadius: BorderRadius.circular(0),
                ),
                children: _getTableList(),
              ),
              const SizedBox(height: 180,),
            ],
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: 0,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                top: BorderSide(
                    width: 1,//宽度
                    color: Colors.white, //边框颜色
                  ),
                ),
              ),

              child: Table(
                border: TableBorder.all(
                  color: widget.lineColor,
                  width: widget.lineWidth,
                  style: BorderStyle.none,//BorderStyle.solid,
                  borderRadius: BorderRadius.circular(0),
                ),
                children: _getTableHeader(),
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 0,
            left: 0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: RaisedButton(child:Text('Today Start',style: TextStyle(color:Colors.white),),color:widget.backgroundColor,onPressed: () { widget.onBegin(); },),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: RaisedButton(child:Text('Any Date',style: TextStyle(color:Colors.white),),color:widget.backgroundColor,onPressed: () { widget.onCreate(); },),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: RaisedButton(child:Text('Today End',style: TextStyle(color:Colors.white),),color:widget.backgroundColor,onPressed: () { widget.onEnd(); },),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            // width: MediaQuery.of(context).size.width,
            bottom: 120,
            right: 5,
            child:
            Card(
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text.rich(TextSpan(
                    children: [
                      const TextSpan( text: 'Distance period',style: TextStyle(fontSize:15.0,),),
                      TextSpan( text: ' ' + widget.typ + ' ',style: TextStyle(fontSize:20.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                      const TextSpan( text: ', has ',style: TextStyle(fontSize:15.0,),),
                      TextSpan( text: ' ' + widget.interval + ' ',style: TextStyle(fontSize:20.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                      const TextSpan( text: 'day',style: TextStyle(fontSize:15.0,),),
                    ]
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

}