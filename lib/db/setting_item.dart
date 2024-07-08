class SettingItem {
  int id;
  String name;
  String value;
  SettingItem({required this.value, required this.name, required this.id});
}

List settings = [
  SettingItem(id: 1, name: 'color', value: '#409EFF'),
  SettingItem(id: 2, name: 'fontSize', value: '14'),
];
