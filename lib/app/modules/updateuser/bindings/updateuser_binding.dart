import 'package:get/get.dart';

import '../controllers/updateuser_controller.dart';

class UpdateuserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateuserController>(
      () => UpdateuserController(),
    );
  }
}
