import 'package:get/get.dart';

import '../controllers/updateperson_controller.dart';

class UpdatepersonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatepersonController>(
      () => UpdatepersonController(),
    );
  }
}
