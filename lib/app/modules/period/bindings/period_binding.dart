import 'package:get/get.dart';

import '../controllers/period_controller.dart';

class PeriodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeriodController>(
      () => PeriodController(),
    );
  }
}
