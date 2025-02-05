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
                        _showEditDialog(context, item["id"], item["name"], scale);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteDialog(context, item["id"], scale);
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
          _showAddDialog(context, scale);
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

  void _showAddDialog(BuildContext context, ScalingUtility scale) {
    TextEditingController itemNameController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: scale.getPadding(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Packing Item",
                style: TextStyle(fontSize: 18,fontFamily: "Fredoka", fontWeight: FontWeight.bold),
              ),
              SizedBox(height: scale.getScaledHeight(12)),
              TextField(
                controller: itemNameController,
                decoration: InputDecoration(
                  hintText: "Enter item name",
                  hintStyle: TextStyle(fontFamily: "Fredoka"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: scale.getScaledHeight(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel", style: TextStyle(color: Colors.red)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (itemNameController.text.trim().isNotEmpty) {
                        packingController.addPackingItem(itemNameController.text.trim());
                        Get.back();
                      }
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, String itemId, String currentName, ScalingUtility scale) {
    TextEditingController itemNameController = TextEditingController(text: currentName);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: scale.getPadding(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Packing Item",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: scale.getScaledHeight(12)),
              TextField(
                controller: itemNameController,
                decoration: InputDecoration(
                  hintText: "Enter new name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: scale.getScaledHeight(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel", style: TextStyle(color: Colors.red)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (itemNameController.text.trim().isNotEmpty) {
                        packingController.editPackingItem(itemId, itemNameController.text.trim());
                        Get.back();
                      }
                    },
                    child: Text("Update"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String itemId, ScalingUtility scale) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: scale.getPadding(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Are you sure you want to delete this item?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: scale.getScaledHeight(12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel", style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      packingController.deletePackingItem(itemId);
                      Get.back();
                    },
                    child: Text("Delete",style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}