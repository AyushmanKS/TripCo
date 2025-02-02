import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../routes/app_routes.dart';

class TripCompanionController extends GetxController {
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var selectedIndex = (-1).obs;
  var companions = <Member>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
    fetchUserEmail();
  }


  void toggleSelection(int index) {
    selectedIndex.value = index;
    companions.clear();

    if (index == 0) {
      // Solo - 1 person
      companions.add(Member(name: '', email: ''));
    } else if (index == 1) {
      // Couple - 2 persons
      companions.addAll([Member(name: '', email: ''), Member(name: '', email: '')]);
    } else if (index == 2) {
      // 2+ members - 3 persons mandatory
      companions.addAll([
        Member(name: '', email: ''),
        Member(name: '', email: ''),
        Member(name: '', email: '')
      ]);
    }
  }

  void addMember() {
    companions.add(Member(name: '', email: ''));
  }

  void removeMember(int index) {
    if (companions.length > 3) {
      companions.removeAt(index);
    }
  }

  void verifyMember(int index) {
    companions[index] = Member(
      name: companions[index].name,
      email: companions[index].email,
      isVerified: !companions[index].isVerified,
    );
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

  Future<void> saveCompanionsToDatabase(String tripId, DateTime startDate, DateTime endDate) async {
    if (tripId.isEmpty) {
      Get.snackbar("Error", "Invalid trip ID.");
      return;
    }

    for (int i = 1; i < companions.length; i++) {
      if (!companions[i].isVerified) {
        Get.snackbar("Error", "Please verify all companions before proceeding.");
        return;
      }
    }

    try {
      Map<String, Map<String, String>> companionsData = {};
      for (int i = 0; i < companions.length; i++) {
        companionsData["companion_${i + 1}"] = {
          "name": companions[i].name,
          "email": companions[i].email,
        };
      }

      await _firestore.collection('trips').doc(tripId).set({
        "trip_companions": companionsData,
      }, SetOptions(merge: true));

      // Navigate to trip schedule screen with tripId, startDate, and endDate
      Get.toNamed(AppRoutes.tripScheduleScreen, arguments: {
        'tripId': tripId,
        'startDate': startDate,
        'endDate': endDate,
      });

    } catch (e) {
      log("Firestore Error: $e");
      Get.snackbar("Error", "Failed to save companions. Please try again.");
    }
  }
}

class Member {
  String name;
  String email;
  bool isVerified;

  Member({required this.name, required this.email, this.isVerified = false});
}
