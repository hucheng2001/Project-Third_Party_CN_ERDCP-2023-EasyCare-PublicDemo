import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../store/login_store.dart';
import '../../../../util/toast.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class LoginController extends GetxController {

  LoginStore loginStore = LoginStore();

  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  static RxString setColor = '#409EFF'.obs;

  Map loginForm = {
    'username': '',
    'password': ''
  };

  bool isShowPassWord = false;
  bool isShowCode = false;
  late Uint8List bytes;


  getSetting() async {
    List colorSettings = await tableDb.getSettingByName('color');
    LoginController.setColor.value = colorSettings[0]['value'];
  }

  // 从本地磁盘获取用户名密码
  _getLoginInfo() async {
    username.text = await loginStore.getUsername() ?? '';
    password.text = await loginStore.getPassword() ?? '';

  }
  Future<void> Login() async {
    await loginStore.setLoginStatus(true);
    handleLogin();
  }

  // 执行登录函数
  Future<void> handleLogin() async {
    var form = loginKey.currentState;
    var isLogin = await loginStore.getLoginStatus();
    if (isLogin){
      if (form!.validate()) {
        form.save();
        loginForm['username'] = username.text;
        loginForm['password'] = password.text;
        Map user = await tableDb.userLogin(loginForm);
        if (user.isNotEmpty){
          loginStore.setUsername(loginForm['username']);
          loginStore.setPassword(loginForm['password']);
          // HomeController.user.value = user;
          Get.offNamed(Routes.HOME);
        } else {
          MyToast.danger('登录失败，请重新尝试！');
        }
      }
    }
  }

  // 跳转到注册页面
  void turnRegister() async {
    Get.toNamed(Routes.REGISTER);
    return ;
  }
  // 点击显示密码的的事件
  void showPassWord() {
    isShowPassWord = !isShowPassWord;
    update(['isShowPassWord']);
  }


  @override
  Future<void> onInit() async {
    await _getLoginInfo();
    await getSetting();
    await handleLogin();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
