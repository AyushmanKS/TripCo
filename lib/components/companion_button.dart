import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../view/trips/controller/trip_companion_controller.dart';

class CompanionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final TripCompanionController controller;
  final int index;

  const CompanionButton(
      {required this.label,
        required this.icon,
        required this.controller,
        required this.index,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () => controller.toggleSelection(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: controller.selectedIndex.value == index
              ? Colors.blueAccent
              : Colors.grey.shade300,
        ),
        child: Column(
          children: [
            Icon(icon,
                color: controller.selectedIndex.value == index
                    ? Colors.white
                    : Colors.black),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: controller.selectedIndex.value == index
                        ? Colors.white
                        : Colors.black)),
          ],
        ),
      ),
    ));
  }
}
