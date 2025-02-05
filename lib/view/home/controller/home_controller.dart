import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var trips = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTrips();
  }

  void fetchTrips() {
    FirebaseFirestore.instance
        .collection('trips')
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((snapshot) {
      isLoading.value = true;

      trips.value = snapshot.docs.map((doc) {
        var trip = doc.data();
        trip['tripId'] = doc.id;
        return trip;
      }).toList();

      isLoading.value = false;
    }, onError: (error) {
      Get.snackbar("Error", "Failed to fetch trips: $error");
      isLoading.value = false;
    });
  }
}