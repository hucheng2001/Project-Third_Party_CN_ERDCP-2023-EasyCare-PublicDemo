import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../util/camera.dart';
import '../../../../util/color.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/register_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    bool isPad = context.isTablet;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,//controller.turnLogin,
        ),
        elevation: 0,
        backgroundColor: ColorUtil.fromHex(LoginController.setColor.value),
        title: const Text('Register'),
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
                  decoration: BoxDecoration(
                    color: ColorUtil.fromHex(LoginController.setColor.value),
                    // image: const DecorationImage(
                    //     image: AssetImage("assets/images/system/background.png"),
                    //     fit: BoxFit.cover
                    // )
                  ),
                  child: ListView(
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                                autovalidateMode: AutovalidateMode.disabled,
                                key: controller.registerKey,
                                child: Column(
                                    children: <Widget>[
                                      MyCamera(
                                        other: Container(),
                                        title: '头像',
                                        width: MediaQuery.of(context).size.height*0.18,
                                        height: MediaQuery.of(context).size.height*0.18,
                                        values: (value) { controller.portrait.text = value; },
                                      ),
                                      SizedBox(height: size.height * 0.01 + 20),
                                      // 账号输入框
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          color: Color(0xFFF2F3F7),
                                        ),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.disabled,
                                          controller: controller.username,
                                          style: const TextStyle(fontSize: 16.0),
                                          maxLength: 16,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.person, color: ColorUtil.fromHex(LoginController.setColor.value)),
                                            hintText: 'Account',
                                            border: InputBorder.none,
                                            counter: const SizedBox(),
                                          ),
                                          validator: (value) {
                                            return value!.trim().isNotEmpty ? null : "账号不能为空";
                                          },
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.01),
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
                                      // 密码输入框
                                      Container(
                                          padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF2F3F7),
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                          ),
                                          child: GetBuilder<RegisterController>(
                                            id: 'isShowPassWord',
                                            init: controller,
                                            builder: (_) => TextFormField(
                                              autovalidateMode: AutovalidateMode.disabled,
                                              controller: controller.password,
                                              style: const TextStyle(fontSize: 16.0),
                                              maxLength: 16,
                                              decoration: InputDecoration(
                                                icon: Icon(Icons.lock, color: ColorUtil.fromHex(LoginController.setColor.value)),
                                                hintText: 'Password',
                                                border: InputBorder.none,
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    controller.isShowPassWord
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: Colors.black54,
                                                  ),
                                                  onPressed: controller.showPassWord,
                                                ),
                                                counter: const SizedBox(),
                                              ),
                                              obscureText: !controller.isShowPassWord,
                                              validator: (value) {
                                                return value!.trim().isNotEmpty
                                                    ? null
                                                    : "密码不能为空";
                                              },
                                            ),
                                          )),
                                      SizedBox(height: size.height * 0.01),

                                      // 注册按钮
                                      Container(
                                        height: 45.0,
                                        margin: const EdgeInsets.only(top: 20.0),
                                        child: SizedBox.expand(
                                          child: ElevatedButton(
                                            onPressed: controller.registerRequest,// 绑定控制层函数
                                            child: Text(
                                              'Register',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: ColorUtil.fromHex(LoginController.setColor.value),//Colors.white,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,//ColorUtil.fromHex(LoginController.setColor.value),
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
