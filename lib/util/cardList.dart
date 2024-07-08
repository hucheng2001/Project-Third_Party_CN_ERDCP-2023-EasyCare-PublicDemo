import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

import 'card.dart';

// 列表聚合上拉加载下拉刷新

class MyCardList extends StatefulWidget {
  // 传入参数
  const MyCardList({
    Key? key,
    required this.DataForm,// 数据列表[{},{}……]
    this.FrontHeight: 0, // 前置高度，避开搜索栏
    required this.pullup, // 上拉回调函数
    required this.dropdown,// 下拉回调函数
    required this.onPressed,// 点击回调函数
    required this.onTap,// 点击回调函数
    required this.onLongPress,
  }) : super(key: key,);
  final List DataForm;
  final double FrontHeight;
  final ValueChanged<Map> onPressed;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onLongPress;
  final VoidCallback pullup;//ValueChanged pullup;//
  final VoidCallback dropdown;//ValueChanged dropdown;//
  @override
  State<StatefulWidget> createState() => MyCardListState();
}

// 构建
class MyCardListState extends State<MyCardList> {
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
    theList = [
      SizedBox(height: widget.FrontHeight,),// 前置高度
    ];
    for(var item in widget.DataForm) {
      theList.add(MyCard(
        showOther: false,
        other: const SizedBox(),
        onTap:(){widget.onTap(item['id']);},
        data:item,
        onLongPress: (){widget.onLongPress(item['id']);},
      ));
    }
    theList.add(SizedBox(height: 50,));
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
        children: _MakeList(),
      ),
    );
  }


}