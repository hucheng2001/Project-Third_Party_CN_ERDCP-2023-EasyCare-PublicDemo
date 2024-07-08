import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../store/login_store.dart';
import '../../../../util/toast.dart';
import '../../home/controllers/home_controller.dart';

class AddpersonController extends GetxController {

  // 初始化缓存
  final LoginStore loginStore = LoginStore();
  // HomeController.user['id']
  // get registerKey => null;
  // name TEXT,portrait TEXT,sex TEXT,tel TEXT,site TEXT,desc TEXT,birthday TEXT,knowDate TEXT,userBy INTEGER
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController portrait = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController site = TextEditingController();
  RxString sex = 'man'.obs;
  RxString birthday = ''.obs;
  RxString knowDate = ''.obs;
  Map personForm = {
    'portrait': '',
    'name': '',
    'sex': '',
    'tel': '',
    'site': '',
    'birthday': '',
    'knowDate': '',
    'desc': '',
    'userBy': null
  };
  createdPerson() async {
    var form = registerKey.currentState;
    if (form!.validate()) {
      form.save();
      if (portrait.text == ''){
        return MyToast.danger('头像不允许为空');
      }
      personForm['portrait'] = portrait.text;
      personForm['name'] = name.text;
      personForm['sex'] = sex.value;
      personForm['tel'] = tel.text;
      personForm['site'] = site.text;
      personForm['birthday'] = birthday.value;
      personForm['knowDate'] = knowDate.value;
      personForm['desc'] = desc.text;
      personForm['userBy'] = Get.arguments['id'];
      var result = await tableDb.addPerson(personForm);
      Get.back(result: true);
      // MyToast.success('Success！');
    }


  }

  @override
  void onInit() {
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
