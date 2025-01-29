import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/scaling_utils_service.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController profileController = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    return Scaffold(
      body: Padding(
        padding: scale.getPadding(vertical: 40, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        profileController.setUserLoggedOut();
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
