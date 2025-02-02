import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_companion/components/custom_button.dart';
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
      appBar: AppBar(title: const Text("Trip Scheduler")),
      body: Column(
        children: [
          SizedBox(
            height: scale.getScaledHeight(50),
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tripScheduleController.tripDays.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        tripScheduleController.selectedDay.value = index,
                    child: Obx(()=>
                      Container(
                        padding: scale.getPadding(horizontal: 12, vertical: 10),
                        margin: scale.getMargin(all: 5),
                        decoration: BoxDecoration(
                          color: tripScheduleController.selectedDay.value == index
                              ? Colors.blue
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(tripScheduleController.tripDays[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => Padding(
                padding: scale.getPadding(all: 10),
                child: TextField(
                  onChanged: (value) {
                    tripScheduleController.dayPlans[
                        tripScheduleController.tripDays[
                            tripScheduleController.selectedDay.value]] = value;
                  },
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText:
                        "Enter your plan for ${tripScheduleController.tripDays[tripScheduleController.selectedDay.value]}",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: scale.getScaledHeight(65),
        padding: scale.getPadding(horizontal: 5, vertical: 10),
        child: CustomButton(
          buttonText: 'Proceed',
          buttonColor: Colors.purple,
          onTap: () {
            tripScheduleController.saveSchedule(tripId!);
          },
        ),
      ),
    );
  }
}
