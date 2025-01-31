import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  'Home',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() => myTrips(scale)),
            ),
          ],
        ),
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
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      itemCount: homeController.trips.length,
      itemBuilder: (context, index) {
        var trip = homeController.trips[index];
        return Container(
          margin: scale.getMargin(vertical: 8, horizontal: 10),
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
                ),
              ),
              SizedBox(height: scale.getScaledHeight(8)),
              Text("Start Date: ${trip['start_date'].toDate()}"),
              Text("End Date: ${trip['end_date'].toDate()}"),
              Text("Start Time: ${trip['start_time']}"),
            ],
          ),
        );
      },
    );
  }

}