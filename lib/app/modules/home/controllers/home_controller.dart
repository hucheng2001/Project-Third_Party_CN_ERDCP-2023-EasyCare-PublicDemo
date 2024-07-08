import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../store/login_store.dart';
import '../../../routes/app_pages.dart';
import '../../login/controllers/login_controller.dart';

class HomeController extends GetxController with StateMixin<List> {

  GlobalKey<FormState> homeKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();

  LoginStore loginStore = LoginStore(); // 登录信息缓存
  RxMap user = {}.obs; // 登录用户信息
  RxList persons = [].obs;

  // Logout登录
  void logout() async {
    // loginStore.setPassword('');
    await loginStore.setLoginStatus(false);
    Get.offAllNamed(Routes.LOGIN);
    Get.delete<HomeController>();
  }
  // 判断是否是登录状态，如果不是的话，Logout到登录界面
  isLogging() async {
    // 获取存储的账号密码确认账号存在
    Map loginForm = {
      'username': '',
      'password': ''
    };
    loginForm['username'] = await loginStore.getUsername() ?? '';
    loginForm['password'] = await loginStore.getPassword() ?? '';
    user.value = await tableDb.userLogin(loginForm);
    // HomeController.user.value = userRes;
    // 存在该用户，判断登录状态
    if (user.value.isNotEmpty){
      var isLogin = await loginStore.getLoginStatus();
      if (!isLogin){
        await loginStore.setLoginStatus(false);
        Get.offAllNamed(Routes.LOGIN);
      }
    } else {
      await loginStore.setLoginStatus(false);
      Get.offAllNamed(Routes.LOGIN);
    }
  }
  // 获取配置信息
  getSetting() async {
    List colorSettings = await tableDb.getSettingByName('color');
    LoginController.setColor.value = colorSettings[0]['value'];
  }
  // 获取档案数据列表
  getPersons() async {
    if (search.text != ''){
       persons.value = await tableDb.getPersonsListBySearch(user.value['id']??0,search.text);
       change(persons, status: RxStatus.success());
    } else {
      // print(user.value['id']);
      persons.value = await tableDb.getPersonsList(user.value['id']??0);
      // print(persons.value);
      change(persons, status: RxStatus.success());
    }

  }


  @override
  Future<void> onInit() async {
    await isLogging();
    await getSetting();
    await getPersons();
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
