import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

// 列表聚合上拉加载下拉刷新

class MyList extends StatefulWidget {
  // 传入参数
  const MyList({
    Key? key,
    required this.DataForm,// 数据列表[{},{}……]
    this.FrontHeight: 0, // 前置高度，避开搜索栏
    required this.pullup, // 上拉回调函数
    required this.dropdown,// 下拉回调函数
    required this.onPressed,// 点击回调函数
    required this.onTap,// 点击回调函数
  }) : super(key: key,);
  final List<Widget> DataForm;
  final double FrontHeight;
  final ValueChanged<Map> onPressed;
  final ValueChanged<int> onTap;
  final VoidCallback pullup;//ValueChanged pullup;//
  final VoidCallback dropdown;//ValueChanged dropdown;//
  @override
  State<StatefulWidget> createState() => MyListState();
}

// 构建
class MyListState extends State<MyList> {
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
        children: widget.DataForm,
      ),
    );
  }
  // Widget _createPage(BuildContext context, AsyncSnapshot snapshot) {
  //   return RefreshIndicator(
  //     color: Colors.blue,//圆圈进度颜色
  //     displacement: 44.0,//下拉停止的距离
  //     backgroundColor: Colors.grey[200],//背景颜色
  //     onRefresh: _onRefresh,
  //     child: ListView(
  //       controller: _controller,
  //       children: widget.DataForm,
  //     ),
  //   );
  // }

  // Future _getData() async {
  //   widget.dropdown();
  //   return widget.dropdown();
  // }

}