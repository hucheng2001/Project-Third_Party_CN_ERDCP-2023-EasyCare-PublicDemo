import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../util/toast.dart';

class NoteController extends GetxController with StateMixin<List> {
  Map personData = {};
  Map typeData = {};
  getArgumentsData(){
    personData = Get.arguments['person'];
    typeData = Get.arguments['type'];
  }

  RxList notes = [].obs;
  GlobalKey<FormState> noteKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();
  TextEditingController name = TextEditingController();

  getNotes() async {
    print(Get.arguments['type']['id']);
    if (Get.arguments['type']['id'] != 0) {
      print(search.text);
      if (search.text != ''){
        notes.value = await tableDb.getNotesListBySearch(Get.arguments['person']['id']??0,Get.arguments['person']['userBy']??0,Get.arguments['type']['id'],search.text,);
        print(notes);
        change(notes, status: RxStatus.success());
      } else {
        notes.value = await tableDb.getNotesList(Get.arguments['person']['id']??0,Get.arguments['person']['userBy']??0,Get.arguments['type']['id']);
        print(notes);
        change(notes, status: RxStatus.success());
      }
    } else {
      if (search.text != ''){
        notes.value = await tableDb.getNotesListBySearchOutType(Get.arguments['person']['id']??0,Get.arguments['person']['userBy']??0,search.text,);
        print(notes);
        change(notes, status: RxStatus.success());
      } else {
        notes.value = await tableDb.getNotesListOutType(Get.arguments['person']['id']??0,Get.arguments['person']['userBy']??0);
        print(notes);
        change(notes, status: RxStatus.success());
      }
    }
  }
  createData() async {
    Map form = {
      'name':name.text,
      'createDate':"${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}",
      'typId':Get.arguments['type']['id'],
      'personBy':Get.arguments['person']['id'],
      'userBy':Get.arguments['person']['userBy'],
    };
    print(form);
    var res = await tableDb.addNote(form);
    MyToast.success('Success！');
    getNotes();
    name.text = '';
  }
  updateData(form) async {
    form['name'] = name.text;
    var res = await tableDb.updateNote(form);
    MyToast.success('修改成功！');
    getNotes();
    name.text = '';
  }
  delNote(id) async {
    var res = await tableDb.deleteNote(id);
    MyToast.success('Del Success！');
    getNotes();
  }
  

  @override
  Future<void> onInit() async {
    await getArgumentsData();
    await getNotes();
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
