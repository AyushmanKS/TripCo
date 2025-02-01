import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../services/scaling_utils_service.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    return Scaffold(
      body: Padding(
        padding: scale.getPadding(top: 40, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: const [
                Text(
                  'My Trips',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Fredoka',
                  ),
                ),
              ],
            ),
            SizedBox(height: scale.getScaledHeight(10),),
            Obx(() => showCountdown(scale)),
            SizedBox(height: scale.getScaledHeight(5),),
            Obx(() => myTrips(scale)),
          ],
        ),
      ),
    );
  }

  Widget showCountdown(ScalingUtility scale) {
    if (homeController.trips.isEmpty) {
      return const SizedBox.shrink();
    }

    DateTime today = DateTime.now();

    List futureTrips = homeController.trips
        .where((trip) {
      DateTime startDate = (trip['start_date'] as Timestamp).toDate();
      return startDate.isAfter(today);
    })
        .toList();
    futureTrips.sort((a, b) => (a['start_date'] as Timestamp).compareTo(b['start_date']));

    if (futureTrips.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red,width: 1),
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFE57373).withValues(alpha: 0.1),
      ),
      child: Column(
        children: futureTrips.map((trip) {
          DateTime startDate = (trip['start_date'] as Timestamp).toDate();
          int daysLeft = startDate.difference(today).inDays;

          if (daysLeft > 0) {
            return Container(
              height: scale.getScaledHeight(50),
              width: double.infinity,
              margin: scale.getMargin(top: 5,bottom: 5, left: 5, right: 5),
              padding: scale.getPadding(all: 12),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.timer, color: Colors.blueAccent),
                  const SizedBox(width: 10),
                  Text(
                    "${trip['destination']} trip starts in $daysLeft days!",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Fredoka',
                    ),
                  ),
                ],
              ),
            );
          }

          return SizedBox.shrink();
        }).toList(),
      ),
    );
  }

  Widget myTrips(ScalingUtility scale) {
    if (homeController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (homeController.trips.isEmpty) {
      return const Center(
        child: Text(
          "No upcoming trips, add a trip now",
          style: TextStyle(fontSize: 18, color: Colors.grey, fontFamily: 'Fredoka'),
        ),
      );
    }

    final DateFormat dateFormat = DateFormat('d MMM yyyy');

    return Expanded(
      child: ListView.builder(
        itemCount: homeController.trips.length,
        itemBuilder: (context, index) {
          var trip = homeController.trips[index];
          DateTime startDate = (trip['start_date'] as Timestamp).toDate();
          DateTime endDate = (trip['end_date'] as Timestamp).toDate();

          return Container(
            margin: scale.getMargin(bottom: 10, left: 5, right: 5),
            padding: scale.getPadding(all: 12),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trip['destination']} Trip",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Fredoka',
                  ),
                ),
                SizedBox(height: scale.getScaledHeight(8)),
                Text("Start Date: ${dateFormat.format(startDate)}", style: TextStyle(fontFamily: 'Fredoka')),
                Text("End Date: ${dateFormat.format(endDate)}", style: TextStyle(fontFamily: 'Fredoka')),
                Text("Start Time: ${trip['start_time']}", style: TextStyle(fontFamily: 'Fredoka')),
              ],
            ),
          );
        },
      ),
    );
  }
}