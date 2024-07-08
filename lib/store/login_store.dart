import 'package:shared_preferences/shared_preferences.dart';

class LoginStore {
  // 设置本地存储登录信息
  bool isLogin = false;

  // 保存用户名(工号)
  setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  // 获取用户名(工号)
  getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    return username;
  }

  // 保存密码
  setPassword(String pwd) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', pwd);
  }

  // 获取密码
  getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final pwd = prefs.getString('password') ?? '';
    return pwd;
  }



  // 保存用户ID
  setUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
  }

  // 获取用户ID
  getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id') ?? '';
    return id;
  }

  // 保存用户名(工号)
  setLoginStatus(bool isLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loginStatus', isLogin);
  }

  // 获取用户名(工号)
  getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.getBool('loginStatus') ?? false;
    return isLogin;
  }



  // Logout登录，清除存储的token等用户信息
  logout() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.clear();
    return result;
  }
}
