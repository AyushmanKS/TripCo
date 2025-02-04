import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PackingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var packingItems = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPackingItems();
  }

  // Fetch Packing Items from Firestore
  void fetchPackingItems() async {
    isLoading.value = true;
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('packing_list').get();

      packingItems.value = querySnapshot.docs
          .map((doc) => {"id": doc.id, "name": doc["name"]})
          .toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load packing items.");
    } finally {
      isLoading.value = false;
    }
  }

  // Add New Packing Item
  void addPackingItem(String itemName) async {
    if (itemName.trim().isEmpty) {
      Get.snackbar("Error", "Item name cannot be empty.");
      return;
    }

    try {
      DocumentReference docRef =
          await _firestore.collection('packing_list').add({"name": itemName});
      packingItems.add({"id": docRef.id, "name": itemName});
      Get.snackbar("Success", "Item added to packing list.");
    } catch (e) {
      Get.snackbar("Error", "Failed to add item.");
    }
  }

  // Edit Packing Item
  void editPackingItem(String itemId, String newItemName) async {
    if (newItemName.trim().isEmpty) {
      Get.snackbar("Error", "Item name cannot be empty.");
      return;
    }

    try {
      await _firestore.collection('packing_list').doc(itemId).update({"name": newItemName});
      int index = packingItems.indexWhere((item) => item["id"] == itemId);
      if (index != -1) {
        packingItems[index]["name"] = newItemName;
        packingItems.refresh();
      }
      Get.snackbar("Success", "Item updated successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to update item.");
    }
  }

  // Delete Packing Item
  void deletePackingItem(String itemId) async {
    try {
      await _firestore.collection('packing_list').doc(itemId).delete();
      packingItems.removeWhere((item) => item["id"] == itemId);
      Get.snackbar("Success", "Item removed from packing list.");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete item.");
    }
  }
}
