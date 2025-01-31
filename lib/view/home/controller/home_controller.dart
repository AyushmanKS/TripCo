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

  Future<void> fetchTrips() async {
    try {
      isLoading.value = true;
      // var snapshot = await FirebaseFirestore.instance.collection('trips').get();
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('trips')
          .orderBy('created_at', descending: true) // list order
          .get();

      trips.value = snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch trips");
    } finally {
      isLoading.value = false;
    }
  }
}
