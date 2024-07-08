import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../store/login_store.dart';

class UpdatepersonController extends GetxController {

  // 初始化缓存
  final LoginStore loginStore = LoginStore();
  // HomeController.user['id']
  // get registerKey => null;
  // name TEXT,portrait TEXT,sex TEXT,tel TEXT,site TEXT,desc TEXT,birthday TEXT,knowDate TEXT,userBy INTEGER
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  // TextEditingController portrait = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController site = TextEditingController();
  RxString portrait = ''.obs;
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
  }.obs;
  // RxMap person = {}.obs;

  getPerson() async {
    print(Get.arguments);
    Map res = await tableDb.getPerson(Get.arguments??0);
    // personForm.value = await tableDb.getPerson(Get.arguments??0);
    // print(res);
    personForm = res;
    print(personForm);
    portrait.value = personForm['portrait'];
    name.text = personForm['name'];
    sex.value = personForm['sex'];
    tel.text = personForm['tel'];
    site.text = personForm['site'];
    if (personForm['birthday'] != ''){
      birthday.value = personForm['birthday'];
    } else {
      birthday.value = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
    }
    if (personForm['knowDate'] != ''){
      knowDate.value = personForm['knowDate'];
    } else {
      knowDate.value = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
    }
    // birthday.value = personForm['birthday'];
    // knowDate.value = personForm['knowDate'];
    desc.text = personForm['desc'];
    personForm['userBy'] = personForm['userBy'];

  }

  void updatePerson() async {
    var form = registerKey.currentState;
    if (form!.validate()) {
      form.save();
      personForm['portrait'] = portrait.value;
      personForm['name'] = name.text;
      personForm['sex'] = sex.value;
      personForm['tel'] = tel.text;
      personForm['site'] = site.text;
      personForm['birthday'] = birthday.value;
      personForm['knowDate'] = knowDate.value;
      personForm['desc'] = desc.text;
      var result = await tableDb.updatePerson(personForm);
      Get.back(result: true);
      // MyToast.success('Success！');
    }


  }

  @override
  Future<void> onInit() async {
    await getPerson();
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
