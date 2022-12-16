import 'package:brain_storm_mania/screens/introduction/introduction.dart';
import 'package:brain_storm_mania/screens/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes{

  static List<GetPage> routes() => [
    GetPage(name: "/", page:() => SplashScreen()),
    GetPage(name: "/introduction", page:() => AppIntroductionScreen()),

  ];
}