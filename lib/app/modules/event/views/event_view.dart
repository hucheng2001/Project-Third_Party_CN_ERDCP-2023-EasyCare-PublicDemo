import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../util/camera.dart';
import '../../../../util/color.dart';
import '../../../../util/eventList.dart';
import '../../../../util/searchfence.dart';
import '../../../../util/toast.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {

  void createBox(context) async {
    Get.defaultDialog(
      title: 'Create Event',
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
                      hintText: 'Event Name',
                      border: InputBorder.none,
                      counter: const SizedBox(),
                    ),
                    validator: (value) {
                      return value!.trim().isNotEmpty ? null : "Event Name";
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
                    autovalidateMode: AutovalidateMode.disabled,
                    controller: controller.typ,
                    style: const TextStyle(fontSize: 16.0),
                    maxLength: 6,
                    decoration: InputDecoration(
                      icon: Icon(Icons.loyalty_outlined, color: ColorUtil.fromHex(LoginController.setColor.value)),
                      hintText: 'Event Type',
                      border: InputBorder.none,
                      counter: const SizedBox(),
                    ),
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
                      hintText: 'Event Remark',
                      border: InputBorder.none,
                      counter: const SizedBox(),
                    ),
                  ),
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
                      // labelText: 'Birthday',
                      icon: Icon(Icons.date_range,color: ColorUtil.fromHex(LoginController.setColor.value),),
                      hintText: 'Select Date',
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
                    initialValue: controller.date.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2200),
                    dateLabelText: 'Select Date',
                    onChanged: (val) => (controller.date.value = val.toString()),
                    validator: (val) {
                      controller.date.value = val!;
                    },
                    onSaved: (val) => controller.date.value = val.toString(),
                  )),
                ),
                SizedBox(height: 5),
                MyCamera(
                  other: Container(),
                  title: '图片',
                  width: MediaQuery.of(context).size.height*0.18,
                  height: MediaQuery.of(context).size.height*0.18,
                  values: (value) { controller.pic.text = value; },
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
      title: 'Edit Event',
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
                    hintText: 'Event Name',
                    border: InputBorder.none,
                    counter: const SizedBox(),
                  ),
                  validator: (value) {
                    return value!.trim().isNotEmpty ? null : "Event Name";
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
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: controller.typ,
                  style: const TextStyle(fontSize: 16.0),
                  maxLength: 6,
                  decoration: InputDecoration(
                    icon: Icon(Icons.loyalty_outlined, color: ColorUtil.fromHex(LoginController.setColor.value)),
                    hintText: 'Event Type',
                    border: InputBorder.none,
                    counter: const SizedBox(),
                  ),
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
                    hintText: 'Event Remark',
                    border: InputBorder.none,
                    counter: const SizedBox(),
                  ),
                ),
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
                    // labelText: 'Birthday',
                    icon: Icon(Icons.date_range,color: ColorUtil.fromHex(LoginController.setColor.value),),
                    hintText: 'Select Date',
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
                  initialValue: controller.date.value,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2200),
                  dateLabelText: 'Select Date',
                  onChanged: (val) => (controller.date.value = val.toString()),
                  validator: (val) {
                    controller.date.value = val!;
                  },
                  onSaved: (val) => controller.date.value = val.toString(),
                )),
              ),
              SizedBox(height: 5),
              MyCamera(
                other: Container(),
                title: '图片',
                width: MediaQuery.of(context).size.height*0.18,
                height: MediaQuery.of(context).size.height*0.18,
                values: (value) { controller.pic.text = value; },
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
          controller.typ.text = '';
          controller.pic.text = '';
          controller.date.value = '';
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
          controller.delEvent(id);
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
        title: const Text('Event'),
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
                child: controller.events.value.isNotEmpty?
                MyEventList(
                  FrontHeight: 50,
                  onEdit: (item) {
                    // print(item);
                    controller.name.text = item['name'];
                    controller.desc.text = item['desc'];
                    controller.typ.text = item['typ'];
                    controller.pic.text = item['pic'];
                    controller.date.value = item['date'];
                    UpdateBox(context,item['id']);
                  },
                  onDel: (item) async {
                    // print(item);
                    delCheck(item['id']);
                  },
                  dropdown: () {  },
                  pullup: () {  },
                  onPressed: (value) {  },
                  DataForm: controller.events.value,
                ):const Text("No record"),
              )),
              Positioned(
                top: 0.0,//距离顶部18px（在中轴线上,因为Stack摆放在正中间）
                child: MySearchFence(
                  fontColor: ColorUtil.fromHex(LoginController.setColor.value),
                  onSearch:(value){controller.search.text= value;controller.getEvents();},// 回调函数传值
                  rightIcon: Icons.restart_alt_outlined,
                  hasRightIcon: false,
                  onIcon:(value){controller.search.text= value;controller.getEvents();},// 回调函数传值
                  onClean: (value){controller.search.text= value;controller.getEvents();},
                  onChange: (value){controller.search.text= value;controller.getEvents();},
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
