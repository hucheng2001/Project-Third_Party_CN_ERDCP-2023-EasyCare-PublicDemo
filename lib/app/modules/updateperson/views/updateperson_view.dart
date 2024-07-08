import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../util/camera.dart';
import '../../../../util/color.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/updateperson_controller.dart';

class UpdatepersonView extends GetView<UpdatepersonController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: Get.back,//controller.turnLogin,
          ),
          elevation: 0,
          backgroundColor: ColorUtil.fromHex(LoginController.setColor.value),
          title: const Text('修改档案'),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },

            child: Center(
                child: Container(
                    width: MediaQuery.of(context).size.width,//size.width * (isPad ? 0.7 : 0.93),
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                  autovalidateMode: AutovalidateMode.disabled,
                                  key: controller.registerKey,
                                  child: Column(
                                      children: <Widget>[
                                        Obx(()=>MyCamera(
                                          defpic: controller.portrait.value,
                                          other: Container(),
                                          title: '头像',
                                          width: MediaQuery.of(context).size.height*0.18,
                                          height: MediaQuery.of(context).size.height*0.18,
                                          values: (value) { controller.portrait.value = value; },
                                        )),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01 + 10),
                                        // 姓名输入框
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
                                              icon: Icon(Icons.face, color: ColorUtil.fromHex(LoginController.setColor.value)),
                                              hintText: 'Name',
                                              border: InputBorder.none,
                                              counter: const SizedBox(),
                                            ),
                                            validator: (value) {
                                              return value!.trim().isNotEmpty ? null : "昵称不能为空";
                                            },
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        // 性别
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
                                                child: Icon(Icons.transgender,color: ColorUtil.fromHex(LoginController.setColor.value),),
                                              ),
                                              const SizedBox(width: 15,),
                                              const SizedBox(width: 5,),
                                              const Text('Male'),
                                              Radio(
                                                value: 'man',
                                                groupValue: controller.sex.value,
                                                onChanged: (T) => {controller.sex.value = T.toString()},
                                              ),
                                              const SizedBox(width: 5,),
                                              const Text('Female'),
                                              Radio(
                                                value: 'woman',
                                                groupValue: controller.sex.value,
                                                onChanged: (T) => {controller.sex.value = T.toString()},
                                              ),
                                              const SizedBox(width: 5,),
                                              const Text('Other'),
                                              Radio(
                                                value: 'other',
                                                groupValue: controller.sex.value,
                                                onChanged: (T) => {controller.sex.value = T.toString()},
                                              ),
                                            ],
                                          )),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        // 电话
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                            color: Color(0xFFF2F3F7),
                                          ),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode.disabled,
                                            controller: controller.tel,
                                            style: const TextStyle(fontSize: 16.0),
                                            maxLength: 11,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.phone, color: ColorUtil.fromHex(LoginController.setColor.value)),
                                              hintText: 'Telephone',
                                              border: InputBorder.none,
                                              counter: const SizedBox(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        // 地址
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                            color: Color(0xFFF2F3F7),
                                          ),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode.disabled,
                                            controller: controller.site,
                                            style: const TextStyle(fontSize: 16.0),
                                            maxLength: 60,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.maps_home_work_rounded, color: ColorUtil.fromHex(LoginController.setColor.value)),
                                              hintText: 'Address',
                                              border: InputBorder.none,
                                              counter: const SizedBox(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        // 生日
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                            color: Color(0xFFF2F3F7),
                                          ),
                                          child: Obx(()=>DateTimePicker(
                                            decoration: InputDecoration(
                                              // labelText: 'Birthday',
                                              icon: Icon(Icons.cake,color: ColorUtil.fromHex(LoginController.setColor.value),),
                                              hintText: 'Birthday',
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
                                            initialValue: controller.birthday.value,
                                            initialDate: DateFormat('yyyy-MM-dd').parse(controller.birthday.value) ,//DateTime.parse(controller.birthday.value),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2200),
                                            dateLabelText: '出生日期',
                                            onChanged: (val) => (controller.birthday.value = val.toString()),
                                            validator: (val) {
                                              controller.birthday.value = val!;
                                            },
                                            onSaved: (val) => controller.birthday.value = val.toString(),
                                          )),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        // 认识于
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                            color: Color(0xFFF2F3F7),
                                          ),
                                          child: Obx(()=>DateTimePicker(
                                            decoration: InputDecoration(
                                              // labelText: 'Birthday',
                                              icon: Icon(Icons.send_time_extension,color: ColorUtil.fromHex(LoginController.setColor.value),),
                                              hintText: 'Meet',
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
                                            initialValue: controller.knowDate.value,
                                            initialDate: DateFormat('yyyy-MM-dd').parse(controller.knowDate.value),//DateTime.parse(controller.knowDate.value),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2200),
                                            dateLabelText: '相识日期',
                                            onChanged: (val) => (controller.knowDate.value = val.toString()),
                                            validator: (val) {
                                              controller.knowDate.value = val!;
                                            },
                                            onSaved: (val) => controller.knowDate.value = val.toString(),
                                          )),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        // Remark
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                            color: Color(0xFFF2F3F7),
                                          ),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode.disabled,
                                            controller: controller.desc,
                                            style: const TextStyle(fontSize: 16.0),
                                            maxLength: 60,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.description, color: ColorUtil.fromHex(LoginController.setColor.value)),
                                              hintText: 'Remark',
                                              border: InputBorder.none,
                                              counter: const SizedBox(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),

                                        // 添加按钮
                                        Container(
                                          height: 45.0,
                                          margin: const EdgeInsets.only(top: 10.0),
                                          child: SizedBox.expand(
                                            child: ElevatedButton(
                                              onPressed: controller.updatePerson,// 绑定控制层函数
                                              child: const Text(
                                                'Check Edit',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: ColorUtil.fromHex(LoginController.setColor.value),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                  )
                              )
                          )
                        ]
                    )
                )
            )

        )
    );
  }
}
