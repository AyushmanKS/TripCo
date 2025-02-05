import 'package:get/get.dart';
import 'package:travel_companion/components/navigation_menu.dart';
import 'package:travel_companion/view/authentication/authentication_screen.dart';
import 'package:travel_companion/view/home/home_screen.dart';
import 'package:travel_companion/view/packing/packing_screen.dart';
import 'package:travel_companion/view/profile/profile_screen.dart';
import 'package:travel_companion/view/splash/splash_screen.dart';
import 'package:travel_companion/view/trips/trip_companion_screen.dart';
import 'package:travel_companion/view/trips/trip_details_screen.dart';
import '../view/trips/trip_schedule_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String homeScreen = '/home_screen';
  static const String authenticationScreen = '/authentication_screen';
  static const String profileScreen = '/profile_screen';
  static const String navigationMenu = '/navigation_menu';
  static const String tripCompanionScreen = '/trip_companion_screen';
  static const String tripScheduleScreen = '/trip_schedule_screen';
  static const String packingScreen = '/packing_screen';
  static const String tripDetailsScreen = '/trip_details_screen';

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
    GetPage(
      name: tripCompanionScreen,
      page: () => TripCompanionScreen(),
    ),
    GetPage(
      name: tripScheduleScreen,
      page: () => TripScheduleScreen(),
    ),
    GetPage(
      name: packingScreen,
      page: () => PackingScreen(),
    ),
    GetPage(
      name: tripDetailsScreen,
      page: () => TripDetailsScreen(),
    ),
  ];
}
