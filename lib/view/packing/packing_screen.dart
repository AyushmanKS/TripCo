import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_companion/view/packing/controller/packing_controller.dart';

import '../../services/scaling_utils_service.dart';

class PackingScreen extends StatelessWidget {
  final PackingController packingController = Get.put(PackingController());

  PackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Packing List',
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
