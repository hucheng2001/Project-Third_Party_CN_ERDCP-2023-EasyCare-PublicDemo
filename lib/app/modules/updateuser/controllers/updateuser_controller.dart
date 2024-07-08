import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../store/login_store.dart';
import '../../../../util/toast.dart';
import '../../../routes/app_pages.dart';

class UpdateuserController extends GetxController {
  // 初始化缓存
  final LoginStore loginStore = LoginStore();
  // get registerKey => null;
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> userKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  // TextEditingController sex = TextEditingController();
  TextEditingController portrait = TextEditingController();
  // TextEditingController birthday = TextEditingController();
  RxString sex = 'man'.obs;
  RxString birthday = ''.obs;
  Map userForm = {
    'username': '',
    'password': '',
    'name': '',
    'sex': '',
    'portrait': '',
    'birthday': '',
  };

  bool isShowPassWord = false;
  bool isShowCode = false;
  late Uint8List bytes;


  // 点击显示密码的的事件
  void showPassWord() {
    isShowPassWord = !isShowPassWord;
    update(['isShowPassWord']);
  }

  var subscription;

  getUserData(){
    username.text = Get.arguments['username'];
    password.text = Get.arguments['password'];
    name.text = Get.arguments['name'];
    sex.value = Get.arguments['sex'];
    portrait.text = Get.arguments['portrait'];
    birthday.value = Get.arguments['birthday'];
  }

  // // 跳转回首页
  // void turnLogin() async {
  //   Get.offAllNamed(Routes.LOGIN);
  //   return ;
  // }
  // 数据更新请求
  void updateRequest() async {
    var form = userKey.currentState;
    if (form!.validate()) {
      form.save();
      userForm['id'] = Get.arguments['id'];
      userForm['username'] = username.text;
      userForm['password'] = password.text;
      userForm['name'] = name.text;
      userForm['sex'] = sex.value;
      userForm['portrait'] = portrait.text;
      userForm['birthday'] = birthday.value;
      var res = await tableDb.updateUser(userForm);
      await loginStore.setUsername(username.text);
      await loginStore.setPassword(password.text);
      Get.back(result: true);
      // if (res.isNotEmpty) {
      //   MyToast.danger('账号已存在，请直接登录！');
      //   loginStore.setUsername(userForm['username']);
      //   Get.offAllNamed(Routes.LOGIN);
      // }

    }


  }





  @override
  void onInit() {
    getUserData();
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
