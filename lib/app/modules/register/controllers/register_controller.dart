import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../store/login_store.dart';
import '../../../../util/toast.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  // 初始化缓存
  final LoginStore loginStore = LoginStore();
  // get registerKey => null;
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  // TextEditingController sex = TextEditingController();
  TextEditingController portrait = TextEditingController();
  // TextEditingController birthday = TextEditingController();
  RxString sex = 'man'.obs;
  RxString birthday = ''.obs;
  Map registerForm = {
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

  // 跳转回首页
  void turnLogin() async {
    Get.offAllNamed(Routes.LOGIN);
    return ;
  }
  // 发送注册请求
  void registerRequest() async {
    var form = registerKey.currentState;
    if (form!.validate()) {
      form.save();
      registerForm['username'] = username.text;
      registerForm['password'] = password.text;
      registerForm['name'] = name.text;
      registerForm['sex'] = sex.value;
      registerForm['portrait'] = portrait.text;
      registerForm['birthday'] = birthday.value;
      Map res = await tableDb.userHas(registerForm['username']);
      if (res.isNotEmpty) {
        MyToast.danger('账号已存在，请直接登录！');
        loginStore.setUsername(registerForm['username']);
        Get.offAllNamed(Routes.LOGIN);
      } else {
        var result = await tableDb.addUser(registerForm);
        MyToast.success('注册成功，请登录！');
        loginStore.setUsername(registerForm['username']);
        loginStore.setPassword(registerForm['password']);
        Get.offAllNamed(Routes.LOGIN);
        return;
      }

    }

    // MyToast.danger('注册中，请稍等');
    // var form = registerKey.currentState;
    // if (form!.validate()) {
    //   form.save();
    //   registerForm['username'] = username.text;
    //   registerForm['realname'] = realname.text;
    //   registerForm['desc'] = desc.text;
    //   registerForm['telephone'] = telephone.text;
    //   registerForm['code'] = code.text;
    //   registerForm['password'] = password.text;
    //
    //   var result = await RegisterApi.register(registerForm);
    //   print(result['code']);
    //   if (result['code'] == 201) {
    //     _loginStorestore.setUsername(registerForm['username']);
    //     _loginStorestore.setPassword(registerForm['password']);
    //     Get.offAllNamed(Routes.LOGIN);
    //     return;
    //   } else if (result['code'] == 401) {
    //     MyToast.danger(result['msg']);
    //   } else {
    //     MyToast.danger('注册失败，请重新尝试！');
    //   }
    // }

  }





  @override
  void onInit() {
    // sex.text = 'man';
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
