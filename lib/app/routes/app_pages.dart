import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/addperson/bindings/addperson_binding.dart';
import '../modules/addperson/views/addperson_view.dart';
import '../modules/event/bindings/event_binding.dart';
import '../modules/event/views/event_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/note/bindings/note_binding.dart';
import '../modules/note/views/note_view.dart';
import '../modules/notetype/bindings/notetype_binding.dart';
import '../modules/notetype/views/notetype_view.dart';
import '../modules/period/bindings/period_binding.dart';
import '../modules/period/views/period_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/table/bindings/table_binding.dart';
import '../modules/table/views/table_view.dart';
import '../modules/todo/bindings/todo_binding.dart';
import '../modules/todo/views/todo_view.dart';
import '../modules/updateperson/bindings/updateperson_binding.dart';
import '../modules/updateperson/views/updateperson_view.dart';
import '../modules/updateuser/bindings/updateuser_binding.dart';
import '../modules/updateuser/views/updateuser_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADDPERSON,
      page: () => AddpersonView(),
      binding: AddpersonBinding(),
    ),
    GetPage(
      name: _Paths.UPDATEPERSON,
      page: () => UpdatepersonView(),
      binding: UpdatepersonBinding(),
    ),
    GetPage(
      name: _Paths.TABLE,
      page: () => TableView(),
      binding: TableBinding(),
    ),
    GetPage(
      name: _Paths.PERIOD,
      page: () => PeriodView(),
      binding: PeriodBinding(),
    ),
    GetPage(
      name: _Paths.EVENT,
      page: () => EventView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: _Paths.TODO,
      page: () => TodoView(),
      binding: TodoBinding(),
    ),
    GetPage(
      name: _Paths.NOTE,
      page: () => NoteView(),
      binding: NoteBinding(),
    ),
    GetPage(
      name: _Paths.NOTETYPE,
      page: () => NotetypeView(),
      binding: NotetypeBinding(),
    ),
    GetPage(
      name: _Paths.UPDATEUSER,
      page: () => UpdateuserView(),
      binding: UpdateuserBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
