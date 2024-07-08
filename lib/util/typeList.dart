import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';


import '../app/modules/login/controllers/login_controller.dart';
import 'color.dart';

// 列表聚合上拉加载下拉刷新

class MyTypeList extends StatefulWidget {
  // 传入参数
  const MyTypeList({
    Key? key,
    required this.DataForm,// 数据列表[{},{}……]
    this.FrontHeight: 0, // 前置高度，避开搜索栏
    required this.pullup, // 上拉回调函数
    required this.dropdown,// 下拉回调函数
    required this.onPressed,// 点击回调函数
    required this.onTap,// 点击回调函数
    required this.onDoubleTap,
    required this.onLongPress,

  }) : super(key: key,);
  final List DataForm;
  final double FrontHeight;
  final ValueChanged<Map> onPressed;
  final ValueChanged<Map> onTap;
  final ValueChanged<Map> onDoubleTap;
  final ValueChanged<Map> onLongPress;
  final VoidCallback pullup;//ValueChanged pullup;//
  final VoidCallback dropdown;//ValueChanged dropdown;//
  @override
  State<StatefulWidget> createState() => MyTypeListState();
}

// 构建
class MyTypeListState extends State<MyTypeList> {
  // 上拉加载回调函数
  final ScrollController _controller = ScrollController();
  // 上拉加载更多
  _loadMore() async {
    /// 强制休眠 1 秒
    await Future.delayed(const Duration(seconds: 1));
    /// 放入到集合中
    setState(() {widget.pullup();});
    setState((){});
  }

  @override
  void initState() {
    /// 为滚动控制器添加监听
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;

      // 在加载的时候锁死
      if (_controller.position.pixels ==
          _controller.position.maxScrollExtent) {
        /// 触发上拉加载更多机制
        _loadMore();
      }
    });
    setState((){});
    super.initState();
  }
  @override
  void dispose() {
    // 销毁 滚动控制器 ScrollController
    _controller.dispose();
    super.dispose();
  }

  _MakeList() {
    List<Widget> theList = [];
    theList.add(
        GestureDetector(
            onTap: () {widget.onTap({'id':0,'name':'全部'});},
            onDoubleTap: () {widget.onDoubleTap({'id':0,'name':'全部'});},
            onLongPress: () {widget.onLongPress({'id':0,'name':'全部'});},
            child: Container(
              decoration: BoxDecoration(
                color: ColorUtil.fromHex(LoginController.setColor.value),
                border: Border.all(color: ColorUtil.fromHex(LoginController.setColor.value), width: 0.8),
                borderRadius: const BorderRadius.all(Radius.circular(5.0))
              ),
              // margin: const EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5,),
              padding: const EdgeInsets.only(right: 7, left: 7, top: 5, bottom: 5,),
              child: const Text.rich(
                  TextSpan(
                      children: [
                        TextSpan( text: '全部' ,style: TextStyle(fontSize:15.0,fontWeight:FontWeight.w600,color: Colors.white),),
                      ]
                  )
              ),
            )
        )
    );
    for(var item in widget.DataForm) {
      theList.add(
        GestureDetector(
            onTap: () {widget.onTap(item);},
            onDoubleTap: () {widget.onDoubleTap(item);},
            onLongPress: () {widget.onLongPress(item);},
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ColorUtil.fromHex(LoginController.setColor.value), width: 0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0))
              ),
              // margin: const EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5,),
              padding: const EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5,),
              child: Text.rich(
                  TextSpan(
                      children: [
                        TextSpan( text: item['name'] ,style: TextStyle(fontSize:15.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                      ]
                  )
              ),
            )
        )
      );
    }
    return theList;
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));// 强制休眠 1 秒
    setState(() {widget.dropdown();});
    return null;
  }



  @override
  Widget build(BuildContext context) {


    return RefreshIndicator(
      color: Colors.blue,//圆圈进度颜色
      displacement: 44.0,//下拉停止的距离
      backgroundColor: Colors.grey[200],//背景颜色
      onRefresh: _onRefresh,
      child: ListView(
        controller: _controller,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 5,),
            child: Wrap(
              direction: Axis.horizontal,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.down,
              alignment: WrapAlignment.start,//spaceAround,//
              spacing: 12,
              runSpacing: 12,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,

              children: _MakeList(),
            ),
          ),
          const SizedBox(height: 100,)
        ],
      ),
    );
  }


}