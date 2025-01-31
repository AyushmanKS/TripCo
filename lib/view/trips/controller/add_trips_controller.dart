import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_companion/view/trips/model/destinations_model.dart';
import 'package:travel_companion/routes/app_routes.dart';

class AddTripController extends GetxController {
  RxBool hideCalender = true.obs;
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<RangeSelectionMode> rangeSelectionMode = Rx<RangeSelectionMode>(RangeSelectionMode.toggledOn);

  RxInt selectedHour = 12.obs;
  RxInt selectedMinute = 0.obs;
  RxString selectedPeriod = 'AM'.obs;

  RxString selectedDestination = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void onDaySelected(DateTime selectedDay, DateTime? newFocusedDay) {
    DateTime today = DateTime.now();

    if (selectedDay.isBefore(today)) {
      return;
    }

    if (startDate.value == null || (startDate.value != null && endDate.value != null)) {
      startDate.value = selectedDay;
      endDate.value = null;
    } else {
      if (selectedDay.isAfter(startDate.value!)) {
        endDate.value = selectedDay;
      } else {
        startDate.value = selectedDay;
        endDate.value = null;
      }
    }

    focusedDay.value = newFocusedDay ?? selectedDay;
  }

  void setTime(int hour, int minute, String period) {
    selectedHour.value = hour;
    selectedMinute.value = minute;
    selectedPeriod.value = period;
  }

  void setDestination(String destination) {
    selectedDestination.value = destination;
  }

  Future<void> saveTripToFirestore() async {
    if (selectedDestination.value.isEmpty ||
        startDate.value == null ||
        endDate.value == null) {
      Get.snackbar("Error", "Please complete all fields before proceeding.");
      return;
    }

    String tripName = "${selectedDestination.value}_trip";
    String startTime = "$selectedHour:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod";

    try {
      await _firestore.collection(tripName).add({
        "destination": selectedDestination.value,
        "start_date": startDate.value,
        "end_date": endDate.value,
        "start_time": startTime,
        "created_at": FieldValue.serverTimestamp(),
      });

      Get.toNamed(AppRoutes.tripCompanionScreen);
    } catch (e) {
      Get.snackbar("Error", "Failed to save trip. Please try again.");
    }
  }

  final List<String> destinations = DestinationModel.destinations;
}
