import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  setUserLoggedOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Get.toNamed(AppRoutes.authenticationScreen);
    prefs.setBool('isUserLoggedIn', false);
  }
}
