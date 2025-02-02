import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_companion/view/trips/controller/trip_companion_controller.dart';
import '../../services/scaling_utils_service.dart';

class TripScheduleScreen extends StatelessWidget {
  final TripCompanionController tripScheduleController =
      Get.put(TripCompanionController());

  TripScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

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
    );
  }
}
