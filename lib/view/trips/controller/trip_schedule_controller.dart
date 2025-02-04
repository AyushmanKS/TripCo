import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TripScheduleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var tripDays = <String>[].obs;
  var dayPlans = <String, String>{}.obs;
  final Map<String, TextEditingController> controllers = {}; 

  void generateDays(DateTime startDate, DateTime endDate) {
    tripDays.clear();
    dayPlans.clear();

    int totalDays = endDate.difference(startDate).inDays + 1;
    for (int i = 0; i < totalDays; i++) {
      String dayLabel = "Day ${i + 1}, ${DateFormat('dd MMM').format(startDate.add(Duration(days: i)))}";
      tripDays.add(dayLabel);
      dayPlans[dayLabel] = "";

      // Ensure the controller is only created once
      controllers.putIfAbsent(dayLabel, () => TextEditingController());
    }
  }

  void saveDayPlan(String tripId, String day) async {
    if (tripId.isEmpty) {
      Get.snackbar("Error", "Invalid trip ID.");
      return;
    }

    String plan = controllers[day]?.text.trim() ?? "";
    plan = plan.isEmpty ? "No plan for today" : plan;

    try {
      await _firestore.collection('trips').doc(tripId).set({
        "trip_schedule.$day": plan,
      }, SetOptions(merge: true));

      dayPlans[day] = plan;
      Get.snackbar("Success", "$day plan saved successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to save $day plan. Try again.");
    }
  }
}
