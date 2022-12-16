import 'package:brain_storm_mania/controllers/auth_controller.dart';
import 'package:brain_storm_mania/controllers/theme_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings{

  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(),permanent: true);
  }
}