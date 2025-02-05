import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/trip_details_controller.dart';
import 'package:intl/intl.dart';

class TripDetailsScreen extends StatelessWidget {
  final TripDetailsController tripDetailsController =
      Get.put(TripDetailsController());

  TripDetailsScreen({super.key});

  String formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('d MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trip Details")),
      body: Obx(() {
        if (tripDetailsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (tripDetailsController.tripData.isEmpty) {
          return const Center(child: Text("Trip details not found."));
        }

        final tripData = tripDetailsController.tripData;
        //final tripSchedule = tripDetailsController.tripSchedule;
        final tripCompanions = tripDetailsController.tripCompanions;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Destination: ${tripData['destination']}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Start Date: ${formatDate(tripData['start_date'])}",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "End Date: ${formatDate(tripData['end_date'])}",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "Start Time: ${tripData['start_time']}",
                  style: const TextStyle(fontSize: 16),
                ),
                // const SizedBox(height: 20),
                // const Text("Trip Schedule:",
                //     style:
                //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                // tripSchedule.isEmpty
                //     ? const Text("No schedule added.",
                //         style: TextStyle(fontSize: 16))
                //     : Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: tripSchedule.entries.map((entry) {
                //           return Text("${entry.key}: ${entry.value}",
                //               style: const TextStyle(fontSize: 16));
                //         }).toList(),
                //       ),
                const SizedBox(height: 20),
                const Text("Trip Companions:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                tripCompanions.isEmpty
                    ? const Text("No companions added.",
                        style: TextStyle(fontSize: 16))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: tripCompanions.map((companion) {
                          return Text("• $companion",
                              style: const TextStyle(fontSize: 16));
                        }).toList(),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
