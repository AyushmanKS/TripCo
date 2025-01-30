import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_companion/components/custom_button.dart';
import 'package:travel_companion/view/trips/controller/trip_companion_controller.dart';
import '../../components/companion_button.dart';
import '../../services/scaling_utils_service.dart';

class TripCompanionScreen extends StatelessWidget {
  final TripCompanionController tripCompanionController =
      Get.put(TripCompanionController());

  TripCompanionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Trip Companions',
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              companionButtons(tripCompanionController),
              Obx(() => tripCompanionController.selectedIndex.value != -1
                  ? Expanded(child: memberInputFields(tripCompanionController, scale))
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(() {
        return tripCompanionController.selectedIndex.value == 2
            ? FloatingActionButton(
          onPressed: tripCompanionController.addMember,
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add, color: Colors.white),
        )
            : const SizedBox.shrink();
      }),
      bottomNavigationBar: Container(
        height: scale.getScaledHeight(65),
        padding: scale.getPadding(horizontal: 10, vertical: 10),
        child: CustomButton(
          buttonText: 'Proceed',
          buttonColor: Colors.purple,
          onTap: (){},
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget companionButtons(TripCompanionController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CompanionButton(
            label: 'Solo',
            icon: Icons.person,
            controller: controller,
            index: 0),
        CompanionButton(
            label: 'Couple',
            icon: Icons.people,
            controller: controller,
            index: 1),
        CompanionButton(
            label: '2+ members',
            icon: Icons.groups,
            controller: controller,
            index: 2),
      ],
    );
  }

  Widget memberInputFields(TripCompanionController controller, ScalingUtility scale) {
    return Obx(
          () => ListView.builder(
        itemCount: controller.companions.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  index == 0 ? 'Myself' : 'Companion $index',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: scale.getScaledHeight(8)),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) =>
                        controller.companions[index].name = value,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(width: scale.getScaledWidth(10)),
                    Expanded(
                      child: TextField(
                        onChanged: (value) =>
                        controller.companions[index].email = value,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            index == 0
                                ? Icons.done_all // Always show done_all for index 0
                                : controller.companions[index].isVerified
                                ? Icons.done_all // For verified, show done_all
                                : Icons.check, // For unverified, show check
                            color: index == 0
                                ? Colors.blue // Blue color for done_all for index 0
                                : controller.companions[index].isVerified
                                ? Colors.blue // Blue for verified
                                : Colors.grey, // Grey for unverified
                          ),
                          onPressed: index == 0
                              ? null // Disable onPressed for index 0
                              : () {
                            // Toggle the verification status for other companions
                            controller.verifyMember(index);
                          },
                        ),
                        if (controller.selectedIndex.value == 2 && index >= 3)
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            onPressed: () => controller.removeMember(index),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}