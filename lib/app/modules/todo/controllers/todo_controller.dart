import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../db/db_helper.dart';
import '../../../../util/toast.dart';

class TodoController extends GetxController with StateMixin<List> {
  //name,desc,beginDate,endDate,beginDateNum,endDateNum,status,tagId,personBy,userBy
  RxList todos = [].obs;
  GlobalKey<FormState> todoKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();

  RxString todoStatus = 'wait'.obs;// start end
  RxInt tagId = 0.obs;
  RxString beginDate = ''.obs;
  RxInt beginDateNum = 0.obs;
  RxString endDate = ''.obs;
  RxInt endDateNum = 0.obs;

  getTodos() async {
    if (search.text != ''){
      todos.value = await tableDb.getTodosListBySearch(Get.arguments['id']??0,Get.arguments['userBy']??0,search.text);
      // print(todos);
      change(todos, status: RxStatus.success());
    } else {
      todos.value = await tableDb.getTodosList(Get.arguments['id']??0,Get.arguments['userBy']??0);
      // print(todos);
      change(todos, status: RxStatus.success());
    }
  }
  createData() async {
    // await getLastTime();
    if (beginDate.value == ''){
      return MyToast.danger('开始时间不能为空');
    }
    if (endDate.value == ''){
      endDate.value = beginDate.value;
    }
    Map form = {
      'name':name.text,
      'desc':desc.text,
      'beginDate':beginDate.value,
      'endDate':endDate.value,
      'beginDateNum':DateFormat('yyyy-MM-dd').parse(beginDate.value).millisecondsSinceEpoch.ceil(),
      'endDateNum':DateFormat('yyyy-MM-dd').parse(endDate.value).millisecondsSinceEpoch.ceil(),
      'status':todoStatus.value,
      'tagId':tagId.value,
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    // print(form);
    var res = await tableDb.addTodo(form);
    MyToast.success('Success！');
    getTodos();
    name.text = '';
    desc.text = '';
    beginDate.value= '';
    endDate.value= '';
    beginDateNum.value= 0;
    endDateNum.value= 0;
    todoStatus.value= 'wait';
    tagId.value= 0;
  }
  updateData(int id) async {
    if (beginDate.value == ''){
      return MyToast.danger('开始时间不能为空');
    }
    if (endDate.value == ''){
      endDate.value = beginDate.value;
    }
    Map form = {
      'id':id,
      'name':name.text,
      'desc':desc.text,
      'beginDate':beginDate.value,
      'endDate':endDate.value,
      'beginDateNum':DateFormat('yyyy-MM-dd').parse(beginDate.value).millisecondsSinceEpoch.ceil(),
      'endDateNum':DateFormat('yyyy-MM-dd').parse(endDate.value).millisecondsSinceEpoch.ceil(),
      'status':todoStatus.value,
      'tagId':tagId.value,
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    // print(form);
    var res = await tableDb.updateTodo(form);
    MyToast.success('修改成功！');
    getTodos();
    name.text = '';
    desc.text = '';
    beginDate.value= '';
    endDate.value= '';
    beginDateNum.value= 0;
    endDateNum.value= 0;
    todoStatus.value= 'wait';
    tagId.value= 0;
  }
  delTodo(int id) async {
    var res = await tableDb.deleteTodo(id);
    MyToast.success('Del Success！');
    getTodos();
  }
  goRun(Map form) async {
    form['status'] = 'start';
    var res = await tableDb.updateTodo(form);
    MyToast.success('Start！');
    getTodos();
  }
  goDone(Map form) async {
    form['status'] = 'end';
    var res = await tableDb.updateTodo(form);
    MyToast.success('Done！');
    getTodos();
  }
  goReset(Map form) async {
    form['status'] = 'wait';
    var res = await tableDb.updateTodo(form);
    MyToast.success('Active！');
    getTodos();
  }
  
  @override
  Future<void> onInit() async {
    await getTodos();
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
