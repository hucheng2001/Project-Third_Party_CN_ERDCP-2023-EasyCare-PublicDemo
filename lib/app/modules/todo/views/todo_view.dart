import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../util/color.dart';
import '../../../../util/searchfence.dart';
import '../../../../util/todoList.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/todo_controller.dart';

class TodoView extends GetView<TodoController> {

  void createBox(context) async {
    Get.defaultDialog(
      title: 'Create Todo',
      radius: 10.0,
      barrierDismissible: false,
      content: Container(
        height: MediaQuery.of(context).size.height * 0.28,
        width: MediaQuery.of(context).size.width * 0.8,
        // margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.white60,
            border: Border.all(color: ColorUtil.fromHex(LoginController.setColor.value), width: 1),
            borderRadius: BorderRadius.circular((10.0))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              // name,pic,desc,typ,date,personBy,userBy
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: controller.name,
                  style: const TextStyle(fontSize: 16.0),
                  maxLength: 16,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    icon: Icon(Icons.drive_file_rename_outline, color: ColorUtil.fromHex(LoginController.setColor.value)),
                    hintText: 'Todo Name',
                    border: InputBorder.none,
                    counter: const SizedBox(),
                  ),
                  validator: (value) {
                    return value!.trim().isNotEmpty ? null : "Todo Name";
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: TextFormField(
                  maxLines: 3,
                  minLines: 1,
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: controller.desc,
                  style: const TextStyle(fontSize: 16.0),
                  maxLength: 60,
                  decoration: InputDecoration(
                    icon: Icon(Icons.description_outlined, color: ColorUtil.fromHex(LoginController.setColor.value)),
                    hintText: 'Todo Remark',
                    border: InputBorder.none,
                    counter: const SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F3F7),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Obx(()=>Row(
                  children: <Widget>[
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Icon(Icons.spoke,color: ColorUtil.fromHex(LoginController.setColor.value),),
                    // ),
                    // const SizedBox(width: 15,),
                    const Text('⭐'),
                    Radio(
                      value: '0',
                      groupValue: controller.tagId.value.toString(),
                      onChanged: (T) => {controller.tagId.value = int.parse(T.toString())},
                    ),
                    const Text('⭐⭐'),
                    Radio(
                      value: '1',
                      groupValue: controller.tagId.value.toString(),
                      onChanged: (T) => {controller.tagId.value = int.parse(T.toString())},
                    ),
                    const Text('⭐⭐⭐'),
                    Radio(
                      value: '2',
                      groupValue: controller.tagId.value.toString(),
                      onChanged: (T) => {controller.tagId.value = int.parse(T.toString())},
                    ),
                  ],
                )),
              ),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: Obx(()=>DateTimePicker(
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range,color: ColorUtil.fromHex(LoginController.setColor.value),),
                    hintText: '选择开始日期',
                    border: InputBorder.none,
                  ),
                  locale: const Locale('zh','CN'),
                  cancelText:'cancel',
                  confirmText: 'confirm',
                  dateHintText: 'Select Date',
                  fieldLabelText: 'Select Date',
                  fieldHintText: 'Select Date',
                  calendarTitle: 'Select Date',
                  dateMask: 'yyyy-MM-d',
                  cursorColor: ColorUtil.fromHex(LoginController.setColor.value),
                  initialValue: controller.beginDate.value,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2200),
                  dateLabelText: '选择开始日期',
                  onChanged: (val) => (controller.beginDate.value = val.toString()),
                  validator: (val) {
                    controller.beginDate.value = val!;
                  },
                  onSaved: (val) => controller.beginDate.value = val.toString(),
                )),
              ),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: Obx(()=>DateTimePicker(
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range,color: ColorUtil.fromHex(LoginController.setColor.value),),
                    hintText: '选择截止日期',
                    border: InputBorder.none,
                  ),
                  locale: const Locale('zh','CN'),
                  cancelText:'cancel',
                  confirmText: 'confirm',
                  dateHintText: 'Select Date',
                  fieldLabelText: 'Select Date',
                  fieldHintText: 'Select Date',
                  calendarTitle: 'Select Date',
                  dateMask: 'yyyy-MM-d',
                  cursorColor: ColorUtil.fromHex(LoginController.setColor.value),
                  initialValue: controller.endDate.value,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2200),
                  dateLabelText: '选择截止日期',
                  onChanged: (val) => (controller.endDate.value = val.toString()),
                  validator: (val) {
                    controller.endDate.value = val!;
                  },
                  onSaved: (val) => controller.endDate.value = val.toString(),
                )),
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
        },
      ),
    );
  }
  void UpdateBox(context,int id) async {
    Get.defaultDialog(
      title: 'Edit Todo',
      radius: 10.0,
      barrierDismissible: false,
      content: Container(
        height: MediaQuery.of(context).size.height * 0.28,
        width: MediaQuery.of(context).size.width * 0.8,
        // margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.white60,
            border: Border.all(color: ColorUtil.fromHex(LoginController.setColor.value), width: 1),
            borderRadius: BorderRadius.circular((10.0))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              // name,pic,desc,typ,date,personBy,userBy
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: controller.name,
                  style: const TextStyle(fontSize: 16.0),
                  maxLength: 16,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    icon: Icon(Icons.drive_file_rename_outline, color: ColorUtil.fromHex(LoginController.setColor.value)),
                    hintText: 'Todo Name',
                    border: InputBorder.none,
                    counter: const SizedBox(),
                  ),
                  validator: (value) {
                    return value!.trim().isNotEmpty ? null : "Todo Name";
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: TextFormField(
                  maxLines: 3,
                  minLines: 1,
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: controller.desc,
                  style: const TextStyle(fontSize: 16.0),
                  maxLength: 60,
                  decoration: InputDecoration(
                    icon: Icon(Icons.description_outlined, color: ColorUtil.fromHex(LoginController.setColor.value)),
                    hintText: 'Todo Remark',
                    border: InputBorder.none,
                    counter: const SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F3F7),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Obx(()=>Row(
                  children: <Widget>[
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Icon(Icons.spoke,color: ColorUtil.fromHex(LoginController.setColor.value),),
                    // ),
                    // const SizedBox(width: 15,),
                    const Text('⭐'),
                    Radio(
                      value: '0',
                      groupValue: controller.tagId.value.toString(),
                      onChanged: (T) => {controller.tagId.value = int.parse(T.toString())},
                    ),
                    const Text('⭐⭐'),
                    Radio(
                      value: '1',
                      groupValue: controller.tagId.value.toString(),
                      onChanged: (T) => {controller.tagId.value = int.parse(T.toString())},
                    ),
                    const Text('⭐⭐⭐'),
                    Radio(
                      value: '2',
                      groupValue: controller.tagId.value.toString(),
                      onChanged: (T) => {controller.tagId.value = int.parse(T.toString())},
                    ),
                  ],
                )),
              ),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: Obx(()=>DateTimePicker(
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range,color: ColorUtil.fromHex(LoginController.setColor.value),),
                    hintText: '选择开始日期',
                    border: InputBorder.none,
                  ),
                  locale: const Locale('zh','CN'),
                  cancelText:'cancel',
                  confirmText: 'confirm',
                  dateHintText: 'Select Date',
                  fieldLabelText: 'Select Date',
                  fieldHintText: 'Select Date',
                  calendarTitle: 'Select Date',
                  dateMask: 'yyyy-MM-d',
                  cursorColor: ColorUtil.fromHex(LoginController.setColor.value),
                  initialValue: controller.beginDate.value,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2200),
                  dateLabelText: '选择开始日期',
                  onChanged: (val) => (controller.beginDate.value = val.toString()),
                  validator: (val) {
                    controller.beginDate.value = val!;
                  },
                  onSaved: (val) => controller.beginDate.value = val.toString(),
                )),
              ),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFF2F3F7),
                ),
                child: Obx(()=>DateTimePicker(
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range,color: ColorUtil.fromHex(LoginController.setColor.value),),
                    hintText: '选择截止日期',
                    border: InputBorder.none,
                  ),
                  locale: const Locale('zh','CN'),
                  cancelText:'cancel',
                  confirmText: 'confirm',
                  dateHintText: 'Select Date',
                  fieldLabelText: 'Select Date',
                  fieldHintText: 'Select Date',
                  calendarTitle: 'Select Date',
                  dateMask: 'yyyy-MM-d',
                  cursorColor: ColorUtil.fromHex(LoginController.setColor.value),
                  initialValue: controller.endDate.value,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2200),
                  dateLabelText: '选择截止日期',
                  onChanged: (val) => (controller.endDate.value = val.toString()),
                  validator: (val) {
                    controller.endDate.value = val!;
                  },
                  onSaved: (val) => controller.endDate.value = val.toString(),
                )),
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
          controller.updateData(id);
        },
      ),
      cancel: MaterialButton(
        color: Colors.white,
        textColor: ColorUtil.fromHex(LoginController.setColor.value),
        child: const Text('cancel', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          controller.name.text = '';
          controller.desc.text = '';
          controller.beginDate.value= '';
          controller.endDate.value= '';
          controller.beginDateNum.value= 0;
          controller.endDateNum.value= 0;
          controller.todoStatus.value= 'wait';
          controller.tagId.value= 0;
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
          controller.delTodo(id);
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
        title: const Text('Todo'),
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
                child: controller.todos.value.isNotEmpty?
                MyTodoList(
                  FrontHeight: 50,
                  onEdit: (item) {
                    // print(item);
                    controller.name.text = item['name'];
                    controller.desc.text = item['desc'];
                    controller.beginDate.value= item['beginDate'];
                    controller.endDate.value= item['endDate'];
                    controller.beginDateNum.value= item['beginDateNum'];
                    controller.endDateNum.value= item['endDateNum'];
                    controller.todoStatus.value= item['status'];
                    controller.tagId.value= item['tagId'];
                    UpdateBox(context,item['id']);
                  },
                  onDel: (item) async {
                    // print(item);
                    delCheck(item['id']);
                  },
                  dropdown: () {  },
                  pullup: () {  },
                  onPressed: (value) {  },
                  DataForm: controller.todos.value,
                  onRun: (value) { controller.goRun(value); },
                  onDone: (value) { controller.goDone(value);},
                  onReset: (value) { controller.goReset(value);},
                ):const Text("No record"),
              )),
              Positioned(
                top: 0.0,//距离顶部18px（在中轴线上,因为Stack摆放在正中间）
                child: MySearchFence(
                  fontColor: ColorUtil.fromHex(LoginController.setColor.value),
                  onSearch:(value){controller.search.text= value;controller.getTodos();},// 回调函数传值
                  rightIcon: Icons.restart_alt_outlined,
                  hasRightIcon: false,
                  onIcon:(value){controller.search.text= value;controller.getTodos();},// 回调函数传值
                  onClean: (value){controller.search.text= value;controller.getTodos();},
                  onChange: (value){controller.search.text= value;controller.getTodos();},
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtil.fromHex(LoginController.setColor.value),
        foregroundColor: Colors.white,
        elevation: 10.0,
        onPressed: () {createBox(context);},
        child: const Icon(Icons.post_add_outlined),
      ),
    );
  }
}
