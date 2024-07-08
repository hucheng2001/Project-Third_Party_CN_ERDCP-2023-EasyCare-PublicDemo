import 'package:get/get.dart';

import '../controllers/addperson_controller.dart';

class AddpersonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddpersonController>(
      () => AddpersonController(),
    );
  }
}
