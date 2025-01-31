import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TripService extends GetxService {
  RxList<Map<String, dynamic>> trips = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;

  static TripService get instance => Get.find();

  Future<void> fetchTrips() async {
    try {
      isLoading.value = true;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('trips')
          .orderBy('created_at', descending: true)
          .get();

      trips.value = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'destination': doc['destination'],
          'start_date': doc['start_date'],
          'end_date': doc['end_date'],
          'start_time': doc['start_time'],
        };
      }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch trips: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
