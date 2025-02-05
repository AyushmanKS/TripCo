import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TripDetailsController extends GetxController {
  var isLoading = true.obs;
  var tripData = {}.obs;
  //var tripSchedule = <String, String>{}.obs;
  var tripCompanions = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTripDetails();
  }

  void fetchTripDetails() async {
    isLoading.value = true;
    final String? tripId = Get.arguments['tripId'];

    if (tripId == null) {
      Get.snackbar("Error", "Invalid trip ID");
      isLoading.value = false;
      return;
    }

    try {
      DocumentSnapshot tripDoc = await FirebaseFirestore.instance
          .collection('trips')
          .doc(tripId)
          .get();

      if (tripDoc.exists) {
        tripData.value = tripDoc.data() as Map<String, dynamic>;

        // if (tripData['trip_schedule'] != null) {
        //   var rawSchedule = tripData['trip_schedule'];
        //   if (rawSchedule is Map) {
        //     tripSchedule.value = rawSchedule.map(
        //         (key, value) => MapEntry(key.toString(), value.toString()));
        //   }
        // }

        if (tripData['trip_companions'] != null) {
          var companionsMap = tripData['trip_companions'];
          if (companionsMap is Map) {
            List<String> companionsList = [];

            companionsMap.forEach((key, companionData) {
              if (companionData is Map &&
                  companionData['name'] != null &&
                  companionData['name'].toString().isNotEmpty) {
                companionsList.add(companionData['name']);
              }
            });

            tripCompanions.value = companionsList;
          }
        }
      } else {
        Get.snackbar("Error", "Trip not found.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load trip details.");
    }

    isLoading.value = false;
  }
}
