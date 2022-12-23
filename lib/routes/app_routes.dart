import 'package:brain_storm_mania/controllers/questions/quesion_paper_controller.dart';
import 'package:brain_storm_mania/controllers/questions/question_controller.dart';
import 'package:brain_storm_mania/controllers/zoom_drawer_controller.dart';
import 'package:brain_storm_mania/screens/home/home_screen.dart';
import 'package:brain_storm_mania/screens/introduction/introduction.dart';
import 'package:brain_storm_mania/screens/question/question_screen.dart';
import 'package:brain_storm_mania/screens/splash/splash_screen.dart';
import 'package:get/get.dart';
import '../screens/login/login_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
            name: "/introduction", page: () => const AppIntroductionScreen()),
        GetPage(
            name: "/home",
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(CustomZoomDrawerController());
            })),
        GetPage(name: LogInScreen.routeName, page: () => const LogInScreen()),
        GetPage(
            name: QuestionScreen.routeName,
            page: () => const QuestionScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionController());
            }))
      ];
}
