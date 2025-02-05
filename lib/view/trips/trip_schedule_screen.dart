import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_companion/components/custom_button.dart';
import '../../routes/app_routes.dart';
import '../../services/scaling_utils_service.dart';
import 'controller/trip_schedule_controller.dart';

class TripScheduleScreen extends StatelessWidget {
  final TripScheduleController tripScheduleController =
      Get.put(TripScheduleController());

  final String? tripId = Get.arguments?['tripId'];
  final DateTime? startDate = Get.arguments?['startDate'];
  final DateTime? endDate = Get.arguments?['endDate'];

  TripScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    if (tripId == null || startDate == null || endDate == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Trip Scheduler")),
        body: const Center(child: Text("Invalid trip details.")),
      );
    }

    tripScheduleController.generateDays(startDate!, endDate!);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trip Scheduler',
          style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Fredoka'),
        ),
      ),
      body: ListView.builder(
        padding: scale.getPadding(all: 10),
        itemCount: tripScheduleController.tripDays.length,
        itemBuilder: (context, index) {
          String day = tripScheduleController.tripDays[index];

          return Card(
            margin: scale.getMargin(bottom: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: scale.getPadding(all: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: scale.getScaledHeight(8)),
                  GetBuilder<TripScheduleController>(
                    id: day,
                    // Unique ID for each day to update only this widget
                    builder: (controller) {
                      return TextField(
                        controller: controller.controllers[day],
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter your plan for $day",
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: scale.getScaledHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          tripScheduleController.saveDayPlan(tripId!, day);
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: scale.getPadding(horizontal: 5, vertical: 10),
        child: SizedBox(
          height: scale.getScaledHeight(45),
          child: CustomButton(
            buttonText: 'Proceed',
            buttonColor: Colors.purple,
            onTap: () {
              Get.toNamed(AppRoutes.packingScreen);
            },
          ),
        ),
      ),
    );
  }
}
