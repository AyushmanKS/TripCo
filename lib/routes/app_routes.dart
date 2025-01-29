import 'package:get/get.dart';
import 'package:travel_companion/components/navigation_menu.dart';
import 'package:travel_companion/view/authentication/authentication_screen.dart';
import 'package:travel_companion/view/home/home_screen.dart';
import 'package:travel_companion/view/profile/profile_screen.dart';
import 'package:travel_companion/view/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String homeScreen = '/home_screen';
  static const String authenticationScreen = '/authentication_screen';
  static const String profileScreen = '/profile_screen';
  static const String navigationMenu = '/navigation_menu';

  static List<GetPage> routes = [
    GetPage(
      name: navigationMenu,
      page: () => NavigationMenu(),
    ),
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: authenticationScreen,
      page: () => AuthenticationScreen(),
    ),
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
    ),
  ];
}
