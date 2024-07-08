import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:easycare/util/toast.dart';

import '../../../../db/db_helper.dart';

class TableController extends GetxController with StateMixin<List> {
  Map personData = {};
  RxList events = [].obs;
  RxInt differenceDays = 0.obs;
  RxString xingzuo = ''.obs;
  RxInt birthdayDifferenceDays = 0.obs;
  getPersonData(){
    personData = Get.arguments;
  }
  getXingzuo(){
    // personData = Get.arguments;
    xingzuo.value = getConstellation(DateFormat('yyyy-MM-dd').parse(personData['birthday']));
    print(xingzuo.value);
  }
  getKnowDateDifference(){
    var startDate = DateFormat('yyyy-MM-dd').parse(personData['knowDate']);
    DateTime endDate = DateTime.now();
    differenceDays.value = endDate.difference(startDate).inDays;
    print(differenceDays.value);
  }
  getBirthdayDifference(){
    DateTime endDate = DateTime.now();
    String oldYear = String.fromCharCodes(personData['birthday'].runes, 0, 4);
    String nowYear = DateTime.now().year.toString();
    String newYear = '';
    String birth = String.fromCharCodes(personData['birthday'].runes, 5, personData['birthday'].runes.length);
    if (birth == '02-29') {
      print('闰月');
      newYear = (int.parse(oldYear) + ((int.parse(nowYear) - int.parse(oldYear))/4).ceil()*4).toString();
      print(newYear);
      String newBirthday = newYear + '-' + birth;
      print(newBirthday);
      if(DateFormat('yyyy-MM-dd').parse(newBirthday).millisecondsSinceEpoch - endDate.millisecondsSinceEpoch >= 0){
        birthdayDifferenceDays.value = DateFormat('yyyy-MM-dd').parse(newBirthday).difference(endDate).inDays + 1;
        print(birthdayDifferenceDays.value);
      } else {
        newYear = (int.parse(oldYear) + ((int.parse(nowYear) - int.parse(oldYear))/4).ceil()*4 + 4 ).toString();
        String newBirthday = newYear + '-' + birth;
        birthdayDifferenceDays.value = DateFormat('yyyy-MM-dd').parse(newBirthday).difference(endDate).inDays + 1;
        print(birthdayDifferenceDays.value);
      }


    } else {
      newYear = nowYear;
      String newBirthday = newYear + '-' + birth;
      if(DateFormat('yyyy-MM-dd').parse(newBirthday).millisecondsSinceEpoch - endDate.millisecondsSinceEpoch >= 0){
        birthdayDifferenceDays.value = DateFormat('yyyy-MM-dd').parse(newBirthday).difference(endDate).inDays + 1;
        print(birthdayDifferenceDays.value);
      } else {
        newYear = (DateTime.now().year + 1).toString();
        String newBirthday = newYear + '-' + birth;
        birthdayDifferenceDays.value = DateFormat('yyyy-MM-dd').parse(newBirthday).difference(endDate).inDays + 1;
        print(birthdayDifferenceDays.value);
      }
    }

    // var startDate = DateFormat('yyyy-MM-dd').parse(personData['knowDate']);
  }
  delPerson() async {
    await tableDb.deletePerson(personData['id']);
    Get.back(result: true);
  }

  getEvents() async {
    var today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    events.value = await tableDb.getEventsListByDate(Get.arguments['id']??0,Get.arguments['userBy']??0,today);
    print(events.value);
    change(events, status: RxStatus.success());
  }

  @override
  Future<void> onInit() async {
    await getPersonData();
    await getKnowDateDifference();
    await getXingzuo();
    await getBirthdayDifference();
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

  static String getConstellation(DateTime birthday) {
    final String capricorn = '摩羯座'; //Capricorn 摩羯座（12月22日～1月20日）
    final String aquarius = '水瓶座'; //Aquarius 水瓶座（1月21日～2月19日）
    final String pisces = '双鱼座'; //Pisces 双鱼座（2月20日～3月20日）
    final String aries = '白羊座'; //3月21日～4月20日
    final String taurus = '金牛座'; //4月21～5月21日
    final String gemini = '双子座'; //5月22日～6月21日
    final String cancer = '巨蟹座'; //Cancer 巨蟹座（6月22日～7月22日）
    final String leo = '狮子座'; //Leo 狮子座（7月23日～8月23日）
    final String virgo = '处女座'; //Virgo 处女座（8月24日～9月23日）
    final String libra = '天秤座'; //Libra 天秤座（9月24日～10月23日）
    final String scorpio = '天蝎座'; //Scorpio 天蝎座（10月24日～11月22日）
    final String sagittarius = '射手座'; //Sagittarius 射手座（11月23日～12月21日）

    int month = birthday.month;
    int day = birthday.day;
    String constellation = '';

    switch (month) {
      case DateTime.january:
        constellation = day < 21 ? capricorn : aquarius;
        break;
      case DateTime.february:
        constellation = day < 20 ? aquarius : pisces;
        break;
      case DateTime.march:
        constellation = day < 21 ? pisces : aries;
        break;
      case DateTime.april:
        constellation = day < 21 ? aries : taurus;
        break;
      case DateTime.may:
        constellation = day < 22 ? taurus : gemini;
        break;
      case DateTime.june:
        constellation = day < 22 ? gemini : cancer;
        break;
      case DateTime.july:
        constellation = day < 23 ? cancer : leo;
        break;
      case DateTime.august:
        constellation = day < 24 ? leo : virgo;
        break;
      case DateTime.september:
        constellation = day < 24 ? virgo : libra;
        break;
      case DateTime.october:
        constellation = day < 24 ? libra : scorpio;
        break;
      case DateTime.november:
        constellation = day < 23 ? scorpio : sagittarius;
        break;
      case DateTime.december:
        constellation = day < 22 ? sagittarius : capricorn;
        break;
    }

    return constellation;
  }
}
