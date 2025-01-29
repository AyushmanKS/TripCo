import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_companion/view/profile/controller/profile_controller.dart';
import '../../services/scaling_utils_service.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  ProfileScreen({super.key});

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
            Row(
              children: [
                Text(
                  'Profile',
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
            SizedBox(height: scale.getScaledHeight(140)),
            Center(
              child: Obx(() => CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.blue,
                    child: profileController.userName.value.isEmpty
                        ? const CircularProgressIndicator()
                        : Center(
                            child: Text(
                              profileController.userName.value
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontSize: 110,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  )),
            ),
            SizedBox(height: scale.getScaledHeight(30)),
            Obx(() {
              if (profileController.userName.value.isEmpty) {
                return const CircularProgressIndicator();
              }
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: scale.getPadding(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white, size: 24),
                      SizedBox(width: scale.getScaledWidth(10)),
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              profileController.userName.value,
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          totalRepeatCount: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: scale.getScaledHeight(10)),
            Obx(() {
              if (profileController.userEmail.value.isEmpty) {
                return const CircularProgressIndicator();
              }
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: scale.getPadding(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.email, color: Colors.white, size: 24),
                      SizedBox(width: scale.getScaledWidth(10)),
                      Text(
                        profileController.userEmail.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
