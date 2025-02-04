import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_companion/components/custom_button.dart';
import 'package:travel_companion/view/packing/controller/packing_controller.dart';
import '../../services/scaling_utils_service.dart';

class PackingScreen extends StatelessWidget {
  final PackingController packingController = Get.put(PackingController());

  PackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)..setCurrentDeviceSize();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Packing List',
          style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Fredoka'),
        ),
      ),
      body: Obx(() {
        if (packingController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: scale.getPadding(all: 10),
          itemCount: packingController.packingItems.length,
          itemBuilder: (context, index) {
            var item = packingController.packingItems[index];

            return Card(
              margin: scale.getMargin(bottom: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  item["name"],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showEditDialog(context, item["id"], item["name"]);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        packingController.deletePackingItem(item["id"]);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Container(
        height: scale.getScaledHeight(65),
        padding: scale.getPadding(horizontal: 5, vertical: 10),
        child: CustomButton(
          buttonText: 'Save',
          buttonColor: Colors.purple,
          onTap: () {},
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  // Dialog to Add New Packing Item
  void _showAddDialog(BuildContext context) {
    TextEditingController itemNameController = TextEditingController();

    Get.defaultDialog(
      title: "Add Packing Item",
      content: Column(
        children: [
          TextField(
            controller: itemNameController,
            decoration: const InputDecoration(
              hintText: "Enter item name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (itemNameController.text.trim().isNotEmpty) {
                packingController.addPackingItem(itemNameController.text.trim());
                Get.back();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // Dialog to Edit Packing Item
  void _showEditDialog(BuildContext context, String itemId, String currentName) {
    TextEditingController itemNameController = TextEditingController(text: currentName);

    Get.defaultDialog(
      title: "Edit Packing Item",
      content: Column(
        children: [
          TextField(
            controller: itemNameController,
            decoration: const InputDecoration(
              hintText: "Enter new name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (itemNameController.text.trim().isNotEmpty) {
                packingController.editPackingItem(itemId, itemNameController.text.trim());
                Get.back();
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
