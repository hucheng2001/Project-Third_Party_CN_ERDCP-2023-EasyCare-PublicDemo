import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:easycare/util/toast.dart';

import '../../../../db/db_helper.dart';

class PeriodController extends GetxController {
  RxList periods = [].obs;
  RxString typ = 'start'.obs;
  RxString day = ''.obs;
  TextEditingController intervalNumText = TextEditingController();
  RxInt intervalNum = 0.obs;
  RxString lastDay = ''.obs;
  RxString lastTyp = 'Start'.obs;
  RxString lastInterval = '0'.obs;
  Map personData = {};
  getPersonData(){
    personData = Get.arguments;
  }


  todayBegin() async {
    await getLastTime();
    // typ,date,interval,personBy,userBy
    Map form = {
      'typ':'start',
      'date':"${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}",
      'interval':0,
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    var startDate = DateFormat('yyyy-MM-dd').parse(lastDay.value);
    DateTime endDate = DateTime.now();
    form['interval'] = endDate.difference(startDate).inDays;

    var res = await tableDb.addPeriod(form);
    MyToast.success('Success！');
    await getPeriods();
    await getStartNum();
    await getEndNum();
    await getLastInterval();
  }
  todayEnd() async {
    await getLastTime();
    // typ,date,interval,personBy,userBy
    Map form = {
      'typ':'end',
      'date':"${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}",
      'interval':0,
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    var startDate = DateFormat('yyyy-MM-dd').parse(lastDay.value);
    DateTime endDate = DateTime.now();
    form['interval'] = endDate.difference(startDate).inDays;

    var res = await tableDb.addPeriod(form);
    MyToast.success('Success！');
    await getPeriods();
    await getStartNum();
    await getEndNum();
    await getLastInterval();
  }
  createData() async {
    await getLastTime();
    if (day.value == ''){
      return MyToast.danger('日期不能为空');
    }
    Map form = {
      'typ':typ.value,
      'date':day.value,
      'interval':0,
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    if (lastDay.value != '') {
      var startDate = DateFormat('yyyy-MM-dd').parse(lastDay.value);
      var endDate = DateFormat('yyyy-MM-dd').parse(day.value);
      form['interval'] = endDate.difference(startDate).inDays;
    }

    var res = await tableDb.addPeriod(form);
    MyToast.success('Success！');
    await getPeriods();
    await getStartNum();
    await getEndNum();
    await getLastInterval();
    typ.value = 'start';
    day.value = '';
  }
  updateData(int id) async {
    Map form = {
      'id': id,
      'typ':typ.value,
      'date':day.value,
      'interval':int.parse(intervalNumText.text),
      'personBy':Get.arguments['id'],
      'userBy':Get.arguments['userBy'],
    };
    var res = await tableDb.updatePeriod(form);
    MyToast.success('修改成功！');
    await getPeriods();
    await getStartNum();
    await getEndNum();
    await getLastInterval();
    typ.value = 'start';
    day.value = '';
    intervalNumText.text = '';
  }

  delPeriod(id) async {
    var res = await tableDb.deletePeriod(id);
    MyToast.success('Del Success！');
    getPeriods();
  }
  getLastTime() async {
    Map res = await tableDb.getPeriodLast(Get.arguments['id']??0,Get.arguments['userBy']??0);
    if (res.isNotEmpty){
      lastDay.value = res['date'];
    } else {
      lastDay.value = '';
    }
  }
  delAllPeriod(int personId) async {
    var res = await tableDb.deleteAllPeriod(personId);
    MyToast.success('Del Success！');
    getPeriods();
  }

  // 获取数据列表
  getPeriods() async {
    periods.value = await tableDb.getPeriodsList(Get.arguments['id']??0,Get.arguments['userBy']??0);
  }

  int startNum = 0;// ceil()
  int startInterval = 0;
  getStartNum() async {
    List startData = await tableDb.getPeriodByType(Get.arguments['id']??0,Get.arguments['userBy']??0,'start');
    // print(startData);
    if (startData.isNotEmpty){
      for (var i = 0; i < startData.length; i++) {
        startNum = startNum + int.parse(startData[i]['interval'].toString());
      }
      startInterval = (startNum/startData.length).ceil();
    } else {
      startInterval = 30;
    }
  }

  int endNum = 0;// ceil()
  int endInterval = 0;
  getEndNum() async {
    List endData = await tableDb.getPeriodByType(Get.arguments['id']??0,Get.arguments['userBy']??0,'end');
    // print(endData);
    if (endData.isNotEmpty){
      for (var i = 0; i < endData.length; i++) {
        endNum = endNum + int.parse(endData[i]['interval'].toString());
      }
      endInterval = (endNum/endData.length).ceil();
    } else {
      endInterval = 6;
    }
  }

  String newDateStr = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
  getLastInterval() async {
    Map res = await tableDb.getPeriodLast(Get.arguments['id']??0,Get.arguments['userBy']??0);
    if (res.isNotEmpty){
      // print(res['typ']);
      // print(res['date']);
      if (res['typ'] == 'end'){
        // print(startInterval);
        DateTime newDate = DateFormat('yyyy-MM-dd').parse(res['date']).add(Duration(days: startInterval));
        newDateStr = "${newDate.year.toString()}-${newDate.month.toString().padLeft(2,'0')}-${newDate.day.toString().padLeft(2,'0')}";
        // print(newDateStr);
        lastTyp.value = 'Start';

      } else if (res['typ'] == 'start') {
        DateTime newDate = DateFormat('yyyy-MM-dd').parse(res['date']).add(Duration(days: endInterval));
        newDateStr = "${newDate.year.toString()}-${newDate.month.toString().padLeft(2,'0')}-${newDate.day.toString().padLeft(2,'0')}";
        // print(newDateStr);
        lastTyp.value = 'End';
      }
    }
    var startDate = DateTime.now();
    var endDate = DateFormat('yyyy-MM-dd').parse(newDateStr);
    int deffday = endDate.difference(startDate).inDays;
    // print(deffday);
    lastInterval.value = deffday.toString();

  }

  @override
  Future<void> onInit() async {
    // await getLastTime();
    await getPersonData();
    await getPeriods();
    await getStartNum();
    await getEndNum();
    await getLastInterval();
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
