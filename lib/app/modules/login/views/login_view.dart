import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/color.dart';
import '../controllers/login_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginView extends GetView<LoginController> {

  @override
  Widget build(BuildContext context) {
    bool isPad = context.isTablet;
    Size size = MediaQuery.of(context).size;
    var colorizeColors = [
      ColorUtil.fromHex(LoginController.setColor.value),
      Colors.black,
      Colors.white,
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 45.0,
      fontFamily: 'Horizon',
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.fromHex(LoginController.setColor.value),
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: ColorUtil.fromHex(LoginController.setColor.value),
                // image: const DecorationImage(
                //     image: AssetImage("assets/images/system/background.png"),
                //     fit: BoxFit.cover
                // )
            ),
            width: MediaQuery.of(context).size.width,//size.width * (isPad ? 0.7 : 0.93),
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.12, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              'Easy Care',
                              textStyle: colorizeTextStyle,
                              colors: colorizeColors,
                            ),
                          ]
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.05, bottom: 10.0,left: 16,right: 16),
                  child: Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: controller.loginKey,
                    child: Column(
                      children: <Widget>[
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
                            style: const TextStyle(fontSize: 20.0),
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
                        SizedBox(height: size.height * 0.02),
                        // 密码输入框
                        Container(
                            padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF2F3F7),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: GetBuilder<LoginController>(
                              id: 'isShowPassWord',
                              init: controller,
                              builder: (_) => TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                controller: controller.password,
                                style: const TextStyle(fontSize: 20.0),
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
                        SizedBox(height: size.height * 0.03),
                        // 登录按钮
                        Container(
                          height: 45.0,
                          margin: const EdgeInsets.only(top: 20.0),
                          child: SizedBox.expand(
                            child: ElevatedButton(
                              onPressed: controller.Login,// 绑定控制层函数
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: ColorUtil.fromHex(LoginController.setColor.value),//Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,//ColorUtil.fromHex(LoginController.setColor.value),
                                // shadowColor: SettingsController.backgroundColor.value,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                // 底部文字按钮
                Container(
                  margin: const EdgeInsets.only(top: 120.0),
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: controller.turnRegister,
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,//Color.fromARGB(255, 53, 53, 53),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      // TextButton(
                      //   onPressed:  controller.turnForget,
                      //   child: Text(
                      //     '忘记密码？',
                      //     style: TextStyle(
                      //       fontSize: 15.0,
                      //       color: Color.fromARGB(255, 53, 53, 53),
                      //       fontWeight: FontWeight.w300,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        '© 2024',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,//Color.fromARGB(255, 53, 53, 53),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
