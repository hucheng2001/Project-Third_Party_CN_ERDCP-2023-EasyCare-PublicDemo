import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../util/color.dart';
import '../../../../util/table.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/period_controller.dart';

class PeriodView extends GetView<PeriodController> {

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
          controller.delPeriod(id);
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
  void delAllCheck(int personId) async {
    Get.defaultDialog(
      title: 'Check Del',
      radius: 10.0,
      barrierDismissible: false,
      content: Center(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text('将删除所有数据，删除后数据将不可恢复，请确认是否删除！',style: TextStyle(color: Colors.red),)
        ),
      ),
      confirm: MaterialButton(
        color: ColorUtil.fromHex(LoginController.setColor.value),
        textColor: Colors.white,
        child: const Text('confirm', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          Get.back();
          controller.delAllPeriod(personId);
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
  void createBox() async {
    Get.defaultDialog(
      title: 'Create Period',
      radius: 10.0,
      barrierDismissible: false,
      content: Container(
        // padding: const EdgeInsets.all(16.0),
        child: Container(
          // margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: Colors.white60,
              border: Border.all(color: ColorUtil.fromHex(LoginController.setColor.value), width: 1),
              borderRadius: BorderRadius.circular((10.0))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F3F7),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Obx(()=>Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.spoke,color: ColorUtil.fromHex(LoginController.setColor.value),),
                      ),
                      const SizedBox(width: 15,),
                      const SizedBox(width: 5,),
                      const Text('Start'),
                      Radio(
                        value: 'start',
                        groupValue: controller.typ.value,
                        onChanged: (T) => {controller.typ.value = T.toString()},
                      ),
                      const SizedBox(width: 5,),
                      const Text('End'),
                      Radio(
                        value: 'end',
                        groupValue: controller.typ.value,
                        onChanged: (T) => {controller.typ.value = T.toString()},
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
                    initialValue: controller.day.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2200),
                    dateLabelText: 'Select Date',
                    onChanged: (val) => (controller.day.value = val.toString()),
                    validator: (val) {
                      controller.day.value = val!;
                    },
                    onSaved: (val) => controller.day.value = val.toString(),
                  )),
                ),
              ],
            )
          )
          ,
        ),
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
  void updateBox(int id) async {
    Get.defaultDialog(
      title: '修改周期',
      radius: 10.0,
      barrierDismissible: false,
      content: Container(
        // padding: const EdgeInsets.all(16.0),
        child: Container(
          // margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: Colors.white60,
              border: Border.all(color: ColorUtil.fromHex(LoginController.setColor.value), width: 1),
              borderRadius: BorderRadius.circular((10.0))),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F3F7),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Obx(()=>Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.spoke,color: ColorUtil.fromHex(LoginController.setColor.value),),
                        ),
                        const SizedBox(width: 15,),
                        const SizedBox(width: 5,),
                        const Text('Start'),
                        Radio(
                          value: 'start',
                          groupValue: controller.typ.value,
                          onChanged: (T) => {controller.typ.value = T.toString()},
                        ),
                        const SizedBox(width: 5,),
                        const Text('End'),
                        Radio(
                          value: 'end',
                          groupValue: controller.typ.value,
                          onChanged: (T) => {controller.typ.value = T.toString()},
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
                      initialValue: controller.day.value,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2200),
                      dateLabelText: 'Select Date',
                      onChanged: (val) => (controller.day.value = val.toString()),
                      validator: (val) {
                        controller.day.value = val!;
                      },
                      onSaved: (val) => controller.day.value = val.toString(),
                    )),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xFFF2F3F7),
                    ),
                    child: Obx(()=>TextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: controller.intervalNumText,
                      style: const TextStyle(fontSize: 16.0),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.donut_large, color: ColorUtil.fromHex(LoginController.setColor.value)),
                        hintText: '请输入整数值',
                        border: InputBorder.none,
                        counter: const SizedBox(),
                      ),
                    )),
                  ),
                ],
              )
          )
          ,
        ),
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
          Get.back();
          controller.intervalNumText.text = '';
          controller.typ.value = 'start';
          controller.day.value = '';
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
        title: const Text('Period'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete,color: Colors.white,),
            onPressed: (){delAllCheck(controller.personData['id']);},//controller.turnLogin,
          ),
        ],
      ),
      body: Container(
        // padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Obx(()=>EasyCare(
            typ: controller.lastTyp.value,
            interval: controller.lastInterval.value,
            onBegin: (){controller.todayBegin();},
            onCreate: (){createBox();},
            onEnd: (){controller.todayEnd();},
            onTap: (value){
              // print(value);
              controller.intervalNumText.text = value['interval'].toString();
              controller.typ.value = value['typ'];
              controller.day.value = value['date'];
              updateBox(value['id']);
              },
            onLongPress: (value){delCheck(value['id']);},
            backgroundColor: ColorUtil.fromHex(LoginController.setColor.value),
            lineColor: ColorUtil.fromHex(LoginController.setColor.value),
            shadowColor: ColorUtil.fromHex('#ffdefb'),
            headerStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),
            rowStyle: TextStyle(color: ColorUtil.fromHex(LoginController.setColor.value),fontWeight: FontWeight.w400,fontSize: 15),
            data: controller.periods.value,
            header:['Date','Status','Gap']
        )),
      ),
    );
  }
}
