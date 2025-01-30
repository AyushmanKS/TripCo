import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import '../services/scaling_utils_service.dart';
import '../view/trips/controller/add_trips_controller.dart';

class TimePickerWidget extends StatelessWidget {
  final AddTripController controller = Get.put(AddTripController());

  TimePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    return Obx(() => Padding(
      padding: scale.getPadding(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: scale.getPadding(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Color(0xFF396c2f),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberPicker(
                  minValue: 1,
                  maxValue: 12,
                  value: controller.selectedHour.value,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: scale.getScaledWidth(40),
                  itemHeight: scale.getScaledHeight(30),
                  onChanged: (value) {
                    controller.setTime(value, controller.selectedMinute.value,
                        controller.selectedPeriod.value);
                  },
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 10),
                  selectedTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 20),
                ),
                NumberPicker(
                  minValue: 0,
                  maxValue: 59,
                  value: controller.selectedMinute.value,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: scale.getScaledWidth(30),
                  itemHeight: scale.getScaledHeight(30),
                  onChanged: (value) {
                    controller.setTime(controller.selectedHour.value, value,
                        controller.selectedPeriod.value);
                  },
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 10),
                  selectedTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Column(
                  children: [
                    _periodButton(controller, "AM",scale),
                    SizedBox(height: scale.getScaledHeight(10)),
                    _periodButton(controller, "PM",scale),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _periodButton(AddTripController controller, String period, ScalingUtility scale) {
    return GestureDetector(
      onTap: () => controller.setTime(
          controller.selectedHour.value, controller.selectedMinute.value, period),
      child: Container(
        padding: scale.getPadding(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: controller.selectedPeriod.value == period
              ? Color(0xFFa3c664)
              : Color(0xFF396c2f),
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          period,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
