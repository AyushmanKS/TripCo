import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_companion/routes/app_routes.dart';

class ProfileController extends GetxController {
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
    fetchUserEmail();
  }

  Future<void> fetchUserName() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        String uid = user.uid;

        DatabaseReference userRef = _database.ref("users/$uid/name");
        DataSnapshot snapshot = await userRef.get();

        if (snapshot.exists) {
          userName.value = snapshot.value.toString();
        } else {
          userName.value = "Name not found";
        }
      } else {
        userName.value = "No user logged in";
      }
    } catch (e) {
      userName.value = "Error fetching name";
      Get.snackbar("Error", "Failed to load profile: $e");
    }
  }

  Future<void> fetchUserEmail() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        String uid = user.uid;

        DatabaseReference userRef = _database.ref("users/$uid/email");
        DataSnapshot snapshot = await userRef.get();

        if (snapshot.exists) {
          userEmail.value = snapshot.value.toString();
        } else {
          userEmail.value = "email not found";
        }
      } else {
        userEmail.value = "No user logged in";
      }
    } catch (e) {
      userEmail.value = "Error fetching email";
      Get.snackbar("Error", "Failed to load profile: $e");
    }
  }

  setUserLoggedOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Get.toNamed(AppRoutes.authenticationScreen);
    prefs.setBool('isUserLoggedIn', false);
  }
}