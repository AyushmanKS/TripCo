import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTripController extends GetxController {
  RxBool hideCalender = true.obs;
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  Rx<RangeSelectionMode> rangeSelectionMode = Rx<RangeSelectionMode>(RangeSelectionMode.toggledOn);


  RxInt selectedHour = 12.obs;
  RxInt selectedMinute = 0.obs;
  RxString selectedPeriod = 'AM'.obs;

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

  void setTime(int hour, int minute, String period) {
    selectedHour.value = hour;
    selectedMinute.value = minute;
    selectedPeriod.value = period;
  }
}
