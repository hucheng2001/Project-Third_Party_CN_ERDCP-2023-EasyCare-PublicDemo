
import 'package:intl/intl.dart';
import 'package:easycare/db/setting_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? db;
  static String? path;
  final String settingTB = "settingTB";   // 配置数据存储
  final String userTB = "userTB";         // 用户数据存储
  final String tagsTB = "tagsTB";         // 标签数据存储
  final String personTB = "personTB";     // 人员数据存储
  final String mPeriodTB = "mPeriodTB";   // 生理周期存储
  final String eventTB = "eventTB";       // 事件数据存储
  final String todoTB = "todoTB";         // 任务数据存储
  final String noteTypeTB = "noteTypeTB"; // 笔记类型存储
  final String notesTB = "notesTB";       // 笔记数据存储
  DBHelper._();

  // 初始化数据库文件
  Future<Database?> initDB() async {
    if (db != null) {
      return db;
    } else {
      path = join(await getDatabasesPath(), 'table.db');
      db = await openDatabase(
        path!,
        version: 1,
        onCreate: (db, ver) async => await populateDB(db),
      );
      return db;
    }
  }
  // 初始化数据库
  populateDB(Database db) async {
    // 创建配置数据库 id 名称 配置
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $settingTB (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,value TEXT)");
    // 导入配置初始数据
    for (int i = 0; i < settings.length; i++) {
      List args = ['${settings[i].name}', '${settings[i].value}'];
      await db.rawInsert(
          "INSERT INTO $settingTB (name,value) VALUES(?,?)", args);
    }

    // 创建用户数据库
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $userTB (id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT,password TEXT,name TEXT,sex TEXT,portrait TEXT,birthday TEXT)");
    // 创建标签数据库
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $tagsTB (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,typ TEXT,userBy INTEGER)");
    // 创建人员数据库
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $personTB (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,portrait TEXT,sex TEXT,tel TEXT,site TEXT,desc TEXT,birthday TEXT,knowDate TEXT,userBy INTEGER)");
    // 创建生理周期数据库
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $mPeriodTB (id INTEGER PRIMARY KEY AUTOINCREMENT,typ TEXT,date TEXT,interval INTEGER,personBy INTEGER,userBy INTEGER)");
    // 创建事件数据库
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $eventTB (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,pic TEXT,desc TEXT,typ TEXT,date TEXT,personBy INTEGER,userBy INTEGER)");
    // 创建任务数据库
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $todoTB (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,desc TEXT,beginDate TEXT,endDate TEXT,beginDateNum INTEGER,endDateNum INTEGER,status TEXT,tagId INTEGER,personBy INTEGER,userBy INTEGER)");
    // 创建笔记类型数据库
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $noteTypeTB (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,personBy INTEGER,userBy INTEGER)");
    // 创建笔记数据库
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $notesTB (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,createDate TEXT,typId INTEGER,personBy INTEGER,userBy INTEGER)");
  }

  Future<int> addSetting(SettingItem item) async {
    String query = "INSERT INTO $settingTB (name,value) VALUES(?,?)";
    List args = [(item.name), (item.value)];
    var res = await db!.rawInsert(query, args);
    return res;
  }
  Future<int> deleteSetting(int id) async {
    String query = "DELETE FROM $settingTB WHERE id=$id";
    var res = await db!.rawDelete(query);
    return res;
  }
  Future<int> updateSetting(SettingItem item) async {
    String query =
        'UPDATE $settingTB SET name = \'${item.name}\', value = \'${item.value}\' WHERE id = ${item.id}';
    var res = await db!.rawUpdate(query);
    return res;
  }
  Future<List<Map>> getSetting() async {
    await initDB();
    String query = "SELECT * FROM $settingTB";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
            'id': res[i]['id'],
            'name': res[i]['name'],
            'value': res[i]['value'],
          },
    );
  }
  Future<List<Map>> getSettingByName(String name) async {
    await initDB();
    String query = "SELECT * FROM $settingTB WHERE name='$name'";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) =>
          {
            'id': res[i]['id'],
            'name': res[i]['name'],
            'value': res[i]['value'],
          },
    );
  }
  Future<Map> searchSettingByName(String name) async {
    await initDB();
    String query = "SELECT * FROM $settingTB WHERE name='$name'";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return {
      'id': res[0]['id'],
      'name': res[0]['name'],
      'value': res[0]['value'],
    };
  }

  Future<int> addUser(Map item) async {
    String query = "INSERT INTO $userTB (username,password,name,sex,portrait,birthday) VALUES(?,?,?,?,?,?)";
    List args = [(item['username']), (item['password']), (item['name']), (item['sex']), (item['portrait']), (item['birthday'])];
    var res = await db!.rawInsert(query, args);
    return res;
  }
  Future<int> updateUser(Map item) async {
    // String query = "INSERT INTO $personTB (name,portrait,sex,tel,site,desc,birthday,knowDate,userBy) VALUES(?,?,?,?,?,?,?,?,?)";
    String query =
        'UPDATE $userTB SET username = \'${item['username']}\', password = \'${item['password']}\', name = \'${item['name']}\', sex = \'${item['sex']}\', portrait = \'${item['portrait']}\',  birthday = \'${item['birthday']}\' WHERE id = ${item['id']}';
    var res = await db!.rawUpdate(query);
    return res;
  }
  Future<Map> userHas(String username) async {
    await initDB();
    String query = "SELECT * FROM $userTB WHERE username='$username'";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    if (res.isNotEmpty) {
      return {
        'id': res[0]['id'],
        'username': res[0]['username'],
        'password': res[0]['password'],
        'name': res[0]['name'],
        'sex': res[0]['sex'],
        'portrait': res[0]['portrait'],
        'birthday': res[0]['birthday'],
      };
    } else {
      return {};
    }

  }
  Future<Map> userLogin(Map item) async {
    await initDB();
    var username = item['username'];
    var password = item['password'];
    String query = "SELECT * FROM $userTB WHERE username='$username' and password='$password'";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    if (res.isNotEmpty) {
      return {
        'id': res[0]['id'],
        'username': res[0]['username'],
        'password': res[0]['password'],
        'name': res[0]['name'],
        'sex': res[0]['sex'],
        'portrait': res[0]['portrait'],
        'birthday': res[0]['birthday'],
      };
    } else {
      return {};
    }

  }

  Future<int> addPerson(Map item) async {
    String query = "INSERT INTO $personTB (name,portrait,sex,tel,site,desc,birthday,knowDate,userBy) VALUES(?,?,?,?,?,?,?,?,?)";
    List args = [(item['name']),(item['portrait']),(item['sex']),(item['tel']),(item['site']),(item['desc']),(item['birthday']),(item['knowDate']),(item['userBy'])];
    var res = await db!.rawInsert(query, args);
    return res;
  }
  Future<int> updatePerson(Map item) async {
    // String query = "INSERT INTO $personTB (name,portrait,sex,tel,site,desc,birthday,knowDate,userBy) VALUES(?,?,?,?,?,?,?,?,?)";
    String query =
        'UPDATE $personTB SET name = \'${item['name']}\', portrait = \'${item['portrait']}\', sex = \'${item['sex']}\', tel = \'${item['tel']}\', site = \'${item['site']}\', desc = \'${item['desc']}\', birthday = \'${item['birthday']}\', knowDate = \'${item['knowDate']}\', userBy = \'${item['userBy']}\' WHERE id = ${item['id']}';
    var res = await db!.rawUpdate(query);
    return res;
  }
  Future<List<Map>> getPersonsList(int userId) async {
    await initDB();
    // String query = "SELECT * FROM $personTB";
    String query = "SELECT * FROM $personTB WHERE userBy='$userId'";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
            'id': res[i]['id'],
            'name': res[i]['name'],
            'portrait': res[i]['portrait'],
            'sex': res[i]['sex'],
            'tel': res[i]['tel'],
            'site': res[i]['site'],
            'desc': res[i]['desc'],
            'birthday': res[i]['birthday'],
            'knowDate': res[i]['knowDate'],
            'userBy': res[i]['userBy'],
      },
    );
  }
  Future<List<Map>> getPersonsListBySearch(int userId,String search) async {
    await initDB();
    String query = "SELECT * FROM $personTB WHERE userBy='$userId' and name LIKE '%$search%'";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'name': res[i]['name'],
        'portrait': res[i]['portrait'],
        'sex': res[i]['sex'],
        'tel': res[i]['tel'],
        'site': res[i]['site'],
        'desc': res[i]['desc'],
        'birthday': res[i]['birthday'],
        'knowDate': res[i]['knowDate'],
        'userBy': res[i]['userBy'],
      },
    );
  }
  Future<Map> getPerson(int id) async {
    await initDB();
    String query = "SELECT * FROM $personTB WHERE id='$id'";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    if (res.isNotEmpty) {
      return {
        'id': res[0]['id'],
        'name': res[0]['name'],
        'portrait': res[0]['portrait'],
        'sex': res[0]['sex'],
        'tel': res[0]['tel'],
        'site': res[0]['site'],
        'desc': res[0]['desc'],
        'birthday': res[0]['birthday'],
        'knowDate': res[0]['knowDate'],
        'userBy': res[0]['userBy'],
      };
    } else {
      return {};
    }

  }
  Future<int> deletePerson(int id) async {
    String query = "DELETE FROM $personTB WHERE id=$id";
    var res = await db!.rawDelete(query);
    return res;
  }

  Future<int> addPeriod(Map item) async {
    String query = "INSERT INTO $mPeriodTB (typ,date,interval,personBy,userBy) VALUES(?,?,?,?,?)";
    List args = [(item['typ']),(item['date']),(item['interval']),(item['personBy']),(item['userBy'])];
    var res = await db!.rawInsert(query, args);
    return res;
  }
  Future<List<Map>> getPeriodsList(int personId,int userId) async {
    await initDB();
    String query = "SELECT * FROM $mPeriodTB WHERE personBy='$personId' and userBy='$userId' ORDER BY date DESC ";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'typ': res[i]['typ'],
        'date': res[i]['date'],
        'interval': res[i]['interval'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }
  Future<Map> getPeriodLast(int personId,int userId) async {
    await initDB();
    String query = "SELECT * FROM $mPeriodTB WHERE personBy='$personId' and userBy='$userId' ORDER BY date DESC ";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    if (res.isNotEmpty){
      return {
        'id': res[0]['id'],
        'typ': res[0]['typ'],
        'date': res[0]['date'],
        'interval': res[0]['interval'],
        'personBy': res[0]['personBy'],
        'userBy': res[0]['userBy'],
      };
    } else {
      return {};
    }
  }
  Future<List<Map>> getPeriodByType(int personId,int userId,String typ) async {
    await initDB();
    String query = "SELECT * FROM $mPeriodTB WHERE personBy='$personId' and userBy='$userId' and typ='$typ' and interval!=0 ORDER BY date DESC ";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'typ': res[i]['typ'],
        'date': res[i]['date'],
        'interval': res[i]['interval'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }
  Future<int> deletePeriod(int id) async {
    String query = "DELETE FROM $mPeriodTB WHERE id=$id";
    var res = await db!.rawDelete(query);
    return res;
  }
  Future<int> deleteAllPeriod(presonId) async {
    String query = "DELETE FROM $mPeriodTB WHERE personBy=$presonId";
    var res = await db!.rawDelete(query);
    return res;
  }
  Future<int> updatePeriod(Map item) async {
    String query =
        'UPDATE $mPeriodTB SET typ = \'${item['typ']}\', date = \'${item['date']}\', interval = \'${item['interval']}\', personBy = \'${item['personBy']}\',userBy = \'${item['userBy']}\' WHERE id = ${item['id']}';
    var res = await db!.rawUpdate(query);
    return res;
  }

  Future<int> addEvent(Map item) async {
    // name,pic,desc,typ,date,personBy,userBy
    String query = "INSERT INTO $eventTB (name,pic,desc,typ,date,personBy,userBy) VALUES(?,?,?,?,?,?,?)";
    List args = [(item['name']),(item['pic']),(item['desc']),(item['typ']),(item['date']),(item['personBy']),(item['userBy'])];
    var res = await db!.rawInsert(query, args);
    return res;
  }
  Future<List<Map>> getEventsList(int personId,int userId) async {
    await initDB();
    String query = "SELECT * FROM $eventTB WHERE personBy='$personId' and userBy='$userId' ORDER BY date DESC ";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'name': res[i]['name'],
        'pic': res[i]['pic'],
        'desc': res[i]['desc'],
        'typ': res[i]['typ'],
        'date': res[i]['date'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }
  Future<List<Map>> getEventsListBySearch(int personId,int userId,String search) async {
    await initDB();
    String query = "SELECT * FROM $eventTB WHERE personBy='$personId' and userBy='$userId' and ( name LIKE '%$search%' or desc LIKE '%$search%' ) ORDER BY date DESC ";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'name': res[i]['name'],
        'pic': res[i]['pic'],
        'desc': res[i]['desc'],
        'typ': res[i]['typ'],
        'date': res[i]['date'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }
  Future<int> updateEvent(Map item) async {
    String query =
        'UPDATE $eventTB SET name = \'${item['name']}\', pic = \'${item['pic']}\', desc = \'${item['desc']}\', typ = \'${item['typ']}\', date = \'${item['date']}\', personBy = \'${item['personBy']}\',userBy = \'${item['userBy']}\' WHERE id = ${item['id']}';
    var res = await db!.rawUpdate(query);
    return res;
  }
  Future<int> deleteEvent(int id) async {
    String query = "DELETE FROM $eventTB WHERE id=$id";
    var res = await db!.rawDelete(query);
    return res;
  }
  Future<List<Map>> getEventsListByDate(int personId,int userId,String date) async {
    await initDB();
    var inDay = DateFormat('yyyy-MM-dd').parse(date);
    var inDay1 = inDay.add(const Duration(days: 1));
    var inDay2 = inDay.add(const Duration(days: 2));
    var inDay3 = inDay.add(const Duration(days: 3));
    DateFormat dayFormat = DateFormat('yyyy-MM-dd');
    var date1 = dayFormat.format(inDay1);
    var date2 = dayFormat.format(inDay2);
    var date3 = dayFormat.format(inDay3);
    String md = date.substring(4);
    String md1 = date1.substring(4);
    String md2 = date2.substring(4);
    String md3 = date3.substring(4);
    String query = "SELECT * FROM $eventTB WHERE personBy='$personId' and userBy='$userId' and ( date LIKE '%$md%' or date LIKE '%$md1%' or date LIKE '%$md2%' or date LIKE '%$md3%') ORDER BY date DESC ";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'name': res[i]['name'],
        'pic': res[i]['pic'],
        'desc': res[i]['desc'],
        'typ': res[i]['typ'],
        'date': res[i]['date'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }

  Future<int> addTodo(Map item) async {
    // name,pic,desc,typ,date,personBy,userBy
    String query = "INSERT INTO $todoTB (name,desc,beginDate,endDate,beginDateNum,endDateNum,status,tagId,personBy,userBy) VALUES(?,?,?,?,?,?,?,?,?,?)";
    List args = [(item['name']),(item['desc']),(item['beginDate']),(item['endDate']),(item['beginDateNum']),(item['endDateNum']),(item['status']),(item['tagId']),(item['personBy']),(item['userBy'])];
    var res = await db!.rawInsert(query, args);
    return res;
  }
  Future<List<Map>> getTodosList(int personId,int userId) async {
    await initDB();
    String query = "SELECT * FROM $todoTB WHERE personBy='$personId' and userBy='$userId' ORDER BY beginDate DESC, status DESC";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'name': res[i]['name'],
        'desc': res[i]['desc'],
        'beginDate': res[i]['beginDate'],
        'endDate': res[i]['endDate'],
        'beginDateNum': res[i]['beginDateNum'],
        'endDateNum': res[i]['endDateNum'],
        'status': res[i]['status'],
        'tagId': res[i]['tagId'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }
  Future<List<Map>> getTodosListBySearch(int personId,int userId,String search) async {
    await initDB();
    String query = "SELECT * FROM $todoTB WHERE personBy='$personId' and userBy='$userId' and ( name LIKE '%$search%' or desc LIKE '%$search%' ) ORDER BY beginDate DESC, status DESC";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
            'id': res[i]['id'],
            'name': res[i]['name'],
            'desc': res[i]['desc'],
            'beginDate': res[i]['beginDate'],
            'endDate': res[i]['endDate'],
            'beginDateNum': res[i]['beginDateNum'],
            'endDateNum': res[i]['endDateNum'],
            'status': res[i]['status'],
            'tagId': res[i]['tagId'],
            'personBy': res[i]['personBy'],
            'userBy': res[i]['userBy'],
          },
    );
  }
  Future<int> updateTodo(Map item) async {
    String query =
        'UPDATE $todoTB SET name = \'${item['name']}\', desc = \'${item['desc']}\', beginDate = \'${item['beginDate']}\', endDate = \'${item['endDate']}\', beginDateNum = \'${item['beginDateNum']}\', endDateNum = \'${item['endDateNum']}\', status = \'${item['status']}\', tagId = \'${item['tagId']}\', personBy = \'${item['personBy']}\',userBy = \'${item['userBy']}\' WHERE id = ${item['id']}';
    var res = await db!.rawUpdate(query);
    return res;
  }
  Future<int> deleteTodo(int id) async {
    String query = "DELETE FROM $todoTB WHERE id=$id";
    var res = await db!.rawDelete(query);
    return res;
  }

  Future<List<Map>> gettypesList(int personId,int userId) async {
    await initDB();
    String query = "SELECT * FROM $noteTypeTB WHERE personBy='$personId' and userBy='$userId' ORDER BY name DESC ";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'name': res[i]['name'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }
  Future<int> addType(Map item) async {
    // name,personBy,userBy
    String query = "INSERT INTO $noteTypeTB (name,personBy,userBy) VALUES(?,?,?)";
    List args = [(item['name']),(item['personBy']),(item['userBy'])];
    var res = await db!.rawInsert(query, args);
    return res;
  }
  Future<int> updateType(Map item) async {
    String query =
        'UPDATE $noteTypeTB SET name = \'${item['name']}\', personBy = \'${item['personBy']}\',userBy = \'${item['userBy']}\' WHERE id = ${item['id']}';
    var res = await db!.rawUpdate(query);
    return res;
  }
  Future<int> deleteType(int id) async {
    String query = "DELETE FROM $noteTypeTB WHERE id=$id";
    var res = await db!.rawDelete(query);
    return res;
  }

  Future<int> addNote(Map item) async {
    // name,personBy,userBy
    String query = "INSERT INTO $notesTB (name,createDate,typId,personBy,userBy) VALUES(?,?,?,?,?)";
    List args = [(item['name']),(item['createDate']),(item['typId']),(item['personBy']),(item['userBy'])];
    var res = await db!.rawInsert(query, args);
    return res;
  }
  Future<int> updateNote(Map item) async {
    String query =
        'UPDATE $notesTB SET name = \'${item['name']}\', createDate = \'${item['createDate']}\', typId = \'${item['typId']}\', personBy = \'${item['personBy']}\',userBy = \'${item['userBy']}\' WHERE id = ${item['id']}';
    var res = await db!.rawUpdate(query);
    return res;
  }
  Future<int> deleteNote(int id) async {
    String query = "DELETE FROM $notesTB WHERE id=$id";
    var res = await db!.rawDelete(query);
    return res;
  }
  Future<int> deleteNoteByType(int typeId) async {
    String query = "DELETE FROM $notesTB WHERE typId=$typeId";
    var res = await db!.rawDelete(query);
    return res;
  }
  Future<List<Map>> getNotesList(int personId,int userId,int typeId) async {
    await initDB();
    String query = "SELECT * FROM $notesTB WHERE personBy='$personId' and userBy='$userId' and typId='$typeId' ORDER BY createDate DESC";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'name': res[i]['name'],
        'createDate': res[i]['createDate'],
        'typId': res[i]['typId'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }
  Future<List<Map>> getNotesListBySearch(int personId,int userId,int typeId,String search) async {
    await initDB();
    String query = "SELECT * FROM $notesTB WHERE personBy='$personId' and userBy='$userId' and typId='$typeId' and name LIKE '%$search%'  ORDER BY createDate DESC";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
            'id': res[i]['id'],
            'name': res[i]['name'],
            'createDate': res[i]['createDate'],
            'typId': res[i]['typId'],
            'personBy': res[i]['personBy'],
            'userBy': res[i]['userBy'],
          },
    );
  }
  Future<List<Map>> getNotesListOutType(int personId,int userId) async {
    await initDB();
    String query = "SELECT * FROM $notesTB WHERE personBy='$personId' and userBy='$userId' ORDER BY createDate DESC";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'name': res[i]['name'],
        'createDate': res[i]['createDate'],
        'typId': res[i]['typId'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }
  Future<List<Map>> getNotesListBySearchOutType(int personId,int userId,String search) async {
    await initDB();
    String query = "SELECT * FROM $notesTB WHERE personBy='$personId' and userBy='$userId' and name LIKE '%$search%' ORDER BY createDate DESC";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    return List.generate(
      res.length,
          (i) => {
        'id': res[i]['id'],
        'name': res[i]['name'],
        'createDate': res[i]['createDate'],
        'typId': res[i]['typId'],
        'personBy': res[i]['personBy'],
        'userBy': res[i]['userBy'],
      },
    );
  }



}
DBHelper tableDb = DBHelper._();
