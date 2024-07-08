import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../util/toast.dart';

class EventController extends GetxController with StateMixin<List>{
  RxList events = [].obs;
  GlobalKey<FormState> eventKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController typ = TextEditingController();
  TextEditingController pic = TextEditingController();
  RxString date = ''.obs;

  getEvents() async {
    if (search.text != ''){
      events.value = await tableDb.getEventsListBySearch(Get.arguments['id']??0,Get.arguments['userBy']??0,search.text);
      // print(events);
      change(events, status: RxStatus.success());
    } else {
      events.value = await tableDb.getEventsList(Get.arguments['id']??0,Get.arguments['userBy']??0);
      // print(events);
      change(events, status: RxStatus.success());
    }
  }
  createData() async {
    // await getLastTime();
    if (date.value == ''){
      return MyToast.danger('日期不能为空');
    }
    Map form = {
      'name':name.text,
      'pic':pic.text,
      'typ':typ.text,
      'date':date.value,
      'desc':desc.text,
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    // print(form);

    var res = await tableDb.addEvent(form);
    MyToast.success('Success！');
    getEvents();
    name.text = '';
    desc.text = '';
    typ.text = '';
    pic.text = '';
    date.value = '';
  }
  updateData(int id) async {
    // await getLastTime();
    if (date.value == ''){
      return MyToast.danger('日期不能为空');
    }
    Map form = {
      'id':id,
      'name':name.text,
      'pic':pic.text,
      'typ':typ.text,
      'date':date.value,
      'desc':desc.text,
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    // print(form);
    var res = await tableDb.updateEvent(form);
    MyToast.success('修改成功！');
    getEvents();
    name.text = '';
    desc.text = '';
    typ.text = '';
    pic.text = '';
    date.value = '';
  }
  delEvent(id) async {
    var res = await tableDb.deleteEvent(id);
    MyToast.success('Del Success！');
    getEvents();
  }

  @override
  Future<void> onInit() async {
    await getEvents();
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
