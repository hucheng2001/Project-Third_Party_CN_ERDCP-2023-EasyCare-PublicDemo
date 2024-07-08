import 'package:get/get.dart';

import '../controllers/notetype_controller.dart';

class NotetypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotetypeController>(
      () => NotetypeController(),
    );
  }
}
