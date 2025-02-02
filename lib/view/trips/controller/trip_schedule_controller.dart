import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TripScheduleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var selectedDay = 0.obs;
  var tripDays = <String>[].obs;
  var dayPlans = <String, String>{}.obs;

  void generateDays(DateTime startDate, DateTime endDate) {
    tripDays.clear();
    dayPlans.clear();
    int totalDays = endDate.difference(startDate).inDays + 1;
    for (int i = 0; i < totalDays; i++) {
      String dayLabel = "Day ${i + 1}, ${DateFormat('dd MMM').format(startDate.add(Duration(days: i)))}";
      tripDays.add(dayLabel);
      dayPlans[dayLabel] = "";
    }
  }

  // void saveSchedule(String tripId) async {
  //   if (tripId.isEmpty) {
  //     Get.snackbar("Error", "Invalid trip ID.");
  //     return;
  //   }
  //
  //   Map<String, String> finalPlans = {};
  //   for (var day in tripDays) {
  //     finalPlans[day] = dayPlans[day]!.isEmpty ? "No plan" : dayPlans[day]!;
  //   }
  //
  //   try {
  //     await _firestore.collection('trips').doc(tripId).set({
  //       "trip_schedule": finalPlans,
  //     }, SetOptions(merge: true));
  //
  //     Get.snackbar("Success", "Trip schedule saved successfully!");
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to save schedule. Try again.");
  //   }
  // }
  void saveSchedule(String tripId) async {
    if (tripId.isEmpty) {
      Get.snackbar("Error", "Invalid trip ID.");
      return;
    }

    List<Map<String, String>> finalPlans = [];
    for (var i = 0; i < tripDays.length; i++) {
      finalPlans.add({
        'day': tripDays[i],
        'plan': dayPlans[tripDays[i]]!.isEmpty ? "No plan" : dayPlans[tripDays[i]]!
      });
    }

    try {
      await _firestore.collection('trips').doc(tripId).set({
        "trip_schedule": finalPlans,
      }, SetOptions(merge: true));

      Get.snackbar("Success", "Trip schedule saved successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to save schedule. Try again.");
    }
  }
}
