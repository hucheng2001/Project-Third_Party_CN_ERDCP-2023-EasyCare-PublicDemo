import 'package:shared_preferences/shared_preferences.dart';

class SettingStore {
  //  存取水印
  setWater(bool water) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setting_water', water);
  }
  getWater() async {
    final prefs = await SharedPreferences.getInstance();
    final water = prefs.getBool('setting_water') ?? true;
    return water;
  }
  //  存取阴影
  setShadow(bool shadow) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setting_shadow', shadow);
  }
  getShadow() async {
    final prefs = await SharedPreferences.getInstance();
    final shadow = prefs.getBool('setting_shadow') ?? true;
    return shadow;
  }
  // 存取主题颜色
  setColor(String color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('setting_color', color);
  }
  getColor() async {
    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getString('setting_color') ?? '';
    return color;
  }

  // 存取列表
  setFullItem(List<String> fullItem) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('setting_fullItem', fullItem);
  }
  getFullItem() async {
    final prefs = await SharedPreferences.getInstance();
    final fullItem = prefs.getStringList('setting_fullItem') ?? [];
    return fullItem;
  }

}