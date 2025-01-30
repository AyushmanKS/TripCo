import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../services/scaling_utils_service.dart';
import '../view/home/home_screen.dart';
import '../view/profile/profile_screen.dart';
import '../view/trips/add_trip_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  NavigationMenuState createState() => NavigationMenuState();
}

class NavigationMenuState extends State<NavigationMenu> {
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(() => controller.screens[controller.selectedIndex.value]),

      bottomNavigationBar: Padding(
        padding: scale.getPadding(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                spreadRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.grey[600],
              activeColor: Colors.white,
              tabBackgroundColor: Colors.blueAccent,
              gap: 8,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              selectedIndex: controller.selectedIndex.value,
              onTabChange: (index) {
                controller.selectedIndex.value = index;
              },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.add_circle_outline_rounded,
                  text: 'Add Trip',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final screens = [HomeScreen(), AddTripScreen(), ProfileScreen()];
}
