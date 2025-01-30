import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_companion/view/trips/controller/trip_companion_controller.dart';

class TripCompanionScreen extends StatelessWidget {
  final TripCompanionController tripCompanionController =
      Get.put(TripCompanionController());

  TripCompanionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Add Trip Companions',
        style: TextStyle(
          fontSize: 28,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      )),
      body: Placeholder(),
    );
  }
}
