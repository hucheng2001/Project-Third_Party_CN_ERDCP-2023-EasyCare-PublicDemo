import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../util/toast.dart';

class NotetypeController extends GetxController with StateMixin<List> {
  Map personData = {};
  RxList types = [].obs;
  GlobalKey<FormState> typeKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();
  TextEditingController name = TextEditingController();

  getUserData() async{
    personData = Get.arguments;
  }
  gettypes() async {
    types.value = await tableDb.gettypesList(Get.arguments['id']??0,Get.arguments['userBy']??0);
    print(types);
    change(types, status: RxStatus.success());
    // if (search.text != ''){
    //   types.value = await tableDb.gettypesListBySearch(Get.arguments['id']??0,Get.arguments['userBy']??0,search.text);
    //   change(types, status: RxStatus.success());
    // } else {
    //   types.value = await tableDb.gettypesList(Get.arguments['id']??0,Get.arguments['userBy']??0);
    //   change(types, status: RxStatus.success());
    // }
  }
  createData() async {
    // await getLastTime();
    if (name.text == ''){
      return MyToast.danger('类型名称不能为空');
    }
    Map form = {
      'name':name.text,
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    // print(form);

    var res = await tableDb.addType(form);
    MyToast.success('Success！');
    gettypes();
    name.text = '';
  }
  updateData(int id) async {
    // await getLastTime();
    if (name.text == ''){
      return MyToast.danger('类型名称不能为空');
    }
    Map form = {
      'id':id,
      'name':name.text,
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    // print(form);
    var res = await tableDb.updateType(form);
    MyToast.success('修改成功！');
    gettypes();
    name.text = '';
  }
  delType(id) async {
    var noteDelRes = await tableDb.deleteNoteByType(id);
    var res = await tableDb.deleteType(id);
    MyToast.success('Del Success！');
    gettypes();
  }
  
  @override
  Future<void> onInit() async {
    await getUserData();
    await gettypes();
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
