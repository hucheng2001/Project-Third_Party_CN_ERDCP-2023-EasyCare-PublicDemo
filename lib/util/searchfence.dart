// import 'dart:async';
// import 'dart:math';
import 'package:flutter/material.dart';

class MySearchFence extends StatefulWidget {
  // 传入参数
  const MySearchFence({
    Key? key,
    this.height = 50.0, // 搜索栏高度
    this.hintText = 'Search', // 搜索栏初始提示
    this.backgroundColor = Colors.white,// 背景色
    this.fontSize = 18,// 文字大小
    this.fontColor = Colors.black,// 文字颜色
    required this.onSearch, // 左侧搜索按钮回调函数
    required this.onIcon,// 右侧图标按钮回调函数
    this.rightIcon = Icons.flip,// 右侧图标
    this.hasRightIcon = true,
    this.leftIcon =Icons.search,// 左侧图标
    required this.onClean,
    required this.onChange,
  }) : super(key: key,);
  final double height;
  final String hintText;
  final Color backgroundColor;
  final double fontSize;
  final Color fontColor;
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onIcon;
  final IconData rightIcon;
  final IconData leftIcon;
  final bool hasRightIcon;
  final ValueChanged<String> onClean;
  final ValueChanged<String> onChange;
  @override
  State<StatefulWidget> createState() => MySearchFenceState();
}

// 监听值变化绑定函数
// void _textFieldChanged(String str) {
//   print(str);
// }

// 构建
class MySearchFenceState extends State<MySearchFence> {
  TextEditingController value = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,// 宽度全屏
        height: widget.height,// 传入高度
        child: Container(
            padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
            decoration: BoxDecoration(
              color: widget.backgroundColor,// 传入背景色
              border: const Border(bottom:BorderSide(width: 1,color: Color(0xffe5e5e5)) ),
              // borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            child:
            Row(
              children: [
                // 左侧搜索按钮
                SizedBox(
                  height: 26,
                  width: 26,
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 53, 53, 53)),
                        minimumSize: MaterialStateProperty.all(const Size(10, 5)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      onPressed: (){widget.onSearch(value.text);},// 回调函数
                      child: Row(
                        children: [
                          Icon(widget.leftIcon,color: widget.fontColor,),
                        ],
                      )
                  ),
                ),
                // 中间搜索框
                SizedBox(
                    height: widget.height,
                    width: widget.hasRightIcon?MediaQuery.of(context).size.width-75:MediaQuery.of(context).size.width-50,
                    child: TextField(
                      controller: value,
                      style: TextStyle(color: widget.fontColor,fontSize: widget.fontSize),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {value.clear();widget.onClean('');},
                            icon: Icon(Icons.cancel, color: widget.fontColor,size: 18,)
                        ),
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: widget.hintText,
                        border: InputBorder.none,
                      ),
                      autofocus: false,
                      onChanged: (str){widget.onChange(str);},
                    )
                ),
                // 右侧自定义图标按钮
                widget.hasRightIcon?SizedBox(
                  height: 26,
                  width: 26,
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 53, 53, 53)),
                        minimumSize: MaterialStateProperty.all(const Size(10, 5)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      onPressed: (){widget.onIcon(value.text);},
                      child: Row(
                        children: [
                          Icon(widget.rightIcon,color: widget.fontColor,),
                        ],
                      )
                  ),
                ):const SizedBox()
              ],
            )
        )
    );
  }
}