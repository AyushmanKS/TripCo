import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_companion/view/trips/controller/add_trips_controller.dart';
import '../../components/custom_button.dart';
import '../../components/time_pickerwidget.dart';
import '../../services/scaling_utils_service.dart';

class AddTripScreen extends StatelessWidget {
  const AddTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    final AddTripController addTripController = Get.put(AddTripController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: scale.getPadding(vertical: 40, horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Add Trip',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Obx(() => IconButton(
                          icon: Icon(addTripController.hideCalender.value ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined, size: 30,),
                          onPressed: () {
                            addTripController.hideCalender.value = !addTripController.hideCalender.value;
                          },
                        ),)
                      ],
                    ),
                    _selectDestination(addTripController, scale),
                    Obx(() => addTripController.hideCalender.value ? _calendar(addTripController, scale) : SizedBox()),
                    SizedBox(height: scale.getScaledHeight(20)),
                    _selectedDates(addTripController, scale),
                    TimePickerWidget(),
                    CustomButton(
                      buttonText: "Proceed",
                      buttonColor: Colors.purple,
                      onTap: () {

                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectDestination(AddTripController controller, ScalingUtility scale) {
    final List<String> destinations = controller.destinations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Destination",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: scale.getScaledHeight(10)),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return destinations.where((destination) =>
                destination.toLowerCase().contains(textEditingValue.text.toLowerCase()));
          },
          onSelected: (String selection) {
            controller.setDestination(selection);
            FocusScope.of(Get.context!).unfocus();
          },
          fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
              FocusNode focusNode, VoidCallback onFieldSubmitted) {
            return Obx(() => TextFormField(
              controller: textEditingController..text = controller.selectedDestination.value,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: "Enter destination",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: Icon(Icons.location_on),
              ),
              onChanged: (value) {
                controller.setDestination(value);
              },
            ));
          },
        ),
      ],
    );
  }

  Widget _calendar(AddTripController controller, ScalingUtility scale) {
    return Padding(
      padding: scale.getPadding(top: 2),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        selectedDayPredicate: (day) =>
        controller.startDate.value != null &&
            day.isAtSameMomentAs(controller.startDate.value!),
        rangeStartDay: controller.startDate.value,
        rangeEndDay: controller.endDate.value,
        calendarFormat: CalendarFormat.month,
        rangeSelectionMode: RangeSelectionMode.toggledOn,
        onDaySelected: (selectedDay, focusedDay) => controller.onDaySelected(selectedDay, focusedDay),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          rangeStartDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          rangeEndDecoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          withinRangeDecoration: BoxDecoration(
            color: Colors.lightBlueAccent.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _selectedDates(AddTripController controller, ScalingUtility scale) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFa3c664),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: scale.getPadding(all: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
              "Start Date: ${controller.startDate.value != null ? controller.startDate.value!.toLocal().toString().split(' ')[0] : 'Not selected'}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )),
            SizedBox(height: scale.getScaledHeight(10)),
            Obx(() => Text(
              "End Date: ${controller.endDate.value != null ? controller.endDate.value!.toLocal().toString().split(' ')[0] : 'Not selected'}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )),
          ],
        ),
      ),
    );
  }
}