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

  RxString selectedDestination = ''.obs;

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

  void setDestination(String destination) {
    selectedDestination.value = destination;
  }

  final List<String> destinations = [
    // North America
    "New York", "Los Angeles", "San Francisco", "Las Vegas", "Chicago", "Miami", "Washington D.C.",
    "Toronto", "Vancouver", "Montreal", "Cancun", "Mexico City",

    // South America
    "Buenos Aires", "Rio de Janeiro", "São Paulo", "Santiago", "Lima", "Bogotá", "Medellín", "Quito",

    // Europe
    "London", "Paris", "Rome", "Milan", "Venice", "Barcelona", "Madrid", "Amsterdam", "Berlin",
    "Munich", "Frankfurt", "Prague", "Vienna", "Budapest", "Warsaw", "Athens", "Zurich", "Geneva",
    "Brussels", "Stockholm", "Copenhagen", "Dublin",

    // Africa
    "Cape Town", "Johannesburg", "Cairo", "Marrakech", "Nairobi", "Zanzibar", "Lagos", "Accra",

    // Asia
    "Tokyo", "Kyoto", "Osaka", "Seoul", "Bangkok", "Phuket", "Chiang Mai", "Singapore",
    "Kuala Lumpur", "Jakarta", "Bali", "Manila", "Ho Chi Minh City", "Hanoi", "Beijing",
    "Shanghai", "Hong Kong", "Taipei", "Mumbai", "New Delhi", "Bengaluru", "Hyderabad",
    "Goa", "Colombo",

    // Australia & Oceania
    "Sydney", "Melbourne", "Brisbane", "Perth", "Adelaide", "Auckland", "Wellington",
    "Christchurch", "Suva",

    // Middle East
    "Dubai", "Abu Dhabi", "Doha", "Riyadh", "Jeddah", "Muscat", "Manama", "Istanbul", "Tel Aviv"
  ];
}
