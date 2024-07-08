import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../util/color.dart';
import '../../../../util/noteList.dart';
import '../../../../util/searchfence.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/note_controller.dart';

class NoteView extends GetView<NoteController> {

  void createBox(context) async {
    Get.defaultDialog(
      title: 'Create Note',
      radius: 10.0,
      barrierDismissible: false,
      content: Container(
        decoration: BoxDecoration(
            color: Colors.white60,
            border: Border.all(color: ColorUtil.fromHex(LoginController.setColor.value), width: 1),
            borderRadius: BorderRadius.circular((10.0))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              // name,pic,desc,typ,date,personBy,userBy
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: TextFormField(
                  maxLines: 3,
                  minLines: 2,
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: controller.name,
                  style: const TextStyle(fontSize: 16.0),
                  maxLength: 60,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    icon: Icon(Icons.drive_file_rename_outline, color: ColorUtil.fromHex(LoginController.setColor.value)),
                    hintText: '请输入随记内容',
                    border: InputBorder.none,
                    counter: const SizedBox(),
                  ),
                  validator: (value) {
                    return value!.trim().isNotEmpty ? null : "随记内容不能为空";
                  },
                ),
              ),
            ],
          ),
        )
        ,
      ),
      confirm: MaterialButton(
        color: ColorUtil.fromHex(LoginController.setColor.value),
        textColor: Colors.white,
        child: const Text('confirm', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          Get.back();
          controller.createData();
        },
      ),
      cancel: MaterialButton(
        color: Colors.white,
        textColor: ColorUtil.fromHex(LoginController.setColor.value),
        child: const Text('cancel', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          Get.back();
          controller.name.text = '';
        },
      ),
    );
  }
  void UpdateBox(context,form) async {
    Get.defaultDialog(
      title: 'Edit Note',
      radius: 10.0,
      barrierDismissible: false,
      content: Container(
        decoration: BoxDecoration(
            color: Colors.white60,
            border: Border.all(color: ColorUtil.fromHex(LoginController.setColor.value), width: 1),
            borderRadius: BorderRadius.circular((10.0))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              // name,pic,desc,typ,date,personBy,userBy
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: TextFormField(
                  maxLines: 3,
                  minLines: 2,
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: controller.name,
                  style: const TextStyle(fontSize: 16.0),
                  maxLength: 60,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    icon: Icon(Icons.drive_file_rename_outline, color: ColorUtil.fromHex(LoginController.setColor.value)),
                    hintText: '请输入随记内容',
                    border: InputBorder.none,
                    counter: const SizedBox(),
                  ),
                  validator: (value) {
                    return value!.trim().isNotEmpty ? null : "随记内容不能为空";
                  },
                ),
              ),
            ],
          ),
        )
        ,
      ),
      confirm: MaterialButton(
        color: ColorUtil.fromHex(LoginController.setColor.value),
        textColor: Colors.white,
        child: const Text('confirm', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          Get.back();
          controller.updateData(form);
          controller.name.text = '';
        },
      ),
      cancel: MaterialButton(
        color: Colors.white,
        textColor: ColorUtil.fromHex(LoginController.setColor.value),
        child: const Text('cancel', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          controller.name.text = '';
          Get.back();
        },
      ),
    );
  }
  void delCheck(int id) async {
    Get.defaultDialog(
      title: 'Check Del',
      radius: 10.0,
      barrierDismissible: false,
      content: Center(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text('删除后数据将不可恢复，请确认是否删除！',style: TextStyle(color: Colors.red),)
        ),
      ),
      confirm: MaterialButton(
        color: ColorUtil.fromHex(LoginController.setColor.value),
        textColor: Colors.white,
        child: const Text('confirm', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          Get.back();
          controller.delNote(id);
        },
      ),
      cancel: MaterialButton(
        color: Colors.white,
        textColor: ColorUtil.fromHex(LoginController.setColor.value),
        child: const Text('cancel', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,//controller.turnLogin,
        ),
        elevation: 0,
        backgroundColor: ColorUtil.fromHex(LoginController.setColor.value),
        title: Text('Note -- ' + controller.typeData['name']),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child:ConstrainedBox( //约束盒子
          constraints: const BoxConstraints.expand(),//不指定高和宽时则铺满整个屏慕
          child: Stack(
            alignment:Alignment.center , //指定对齐方式为居中
            children: <Widget>[ //子组件列表
              controller.obx((state) => Center(
                child: controller.notes.value.isNotEmpty?
                MyNoteList(
                  FrontHeight: 50,
                  onDoubleTap: (item) {
                    // print(item);
                    controller.name.text = item['name'];
                    UpdateBox(context,item);
                  },
                  onLongPress: (item) async {
                    // print(item);
                    delCheck(item['id']);
                  },
                  onTap: (item){ },
                  dropdown: () {  },
                  pullup: () {  },
                  onPressed: (value) {  },
                  DataForm: controller.notes.value,
                ):const Text("No record"),
              )),
              Positioned(
                top: 0.0,//距离顶部18px（在中轴线上,因为Stack摆放在正中间）
                child: MySearchFence(
                  fontColor: ColorUtil.fromHex(LoginController.setColor.value),
                  onSearch:(value){controller.search.text= value;controller.getNotes();},// 回调函数传值
                  rightIcon: Icons.restart_alt_outlined,
                  hasRightIcon: false,
                  onIcon:(value){controller.search.text= value;controller.getNotes();},// 回调函数传值
                  onClean: (value){controller.search.text= value;controller.getNotes();},
                  onChange: (value){controller.search.text= value;controller.getNotes();},
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: controller.typeData['id']==0?null:FloatingActionButton(
        backgroundColor: ColorUtil.fromHex(LoginController.setColor.value),
        foregroundColor: Colors.white,
        elevation: 10.0,
        onPressed: () {createBox(context);},
        child: const Icon(Icons.post_add_outlined),
      ),
    );
  }
}
