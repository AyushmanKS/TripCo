import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTripController extends GetxController {
  RxBool hideCalender = false.obs;
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  Rx<RangeSelectionMode> rangeSelectionMode = Rx<RangeSelectionMode>(RangeSelectionMode.toggledOn);

  void onDaySelected(DateTime selectedDay, DateTime? focusedDay) {
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
  }
}
