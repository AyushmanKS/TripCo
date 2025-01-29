import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/scaling_utils_service.dart';
import '../view/home/home_screen.dart';
import '../view/profile/profile_screen.dart';
import '../view/trips/add_trip_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  NavigationMenuState createState() => NavigationMenuState();
}

class NavigationMenuState extends State<NavigationMenu> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Stack(
        children: [

          Obx(() => controller.screens[controller.selectedIndex.value]),

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
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
              margin: scale.getPadding(horizontal: 50),
              child: Padding(
                padding: scale.getPadding(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Home button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.home, color: Colors.blue, size: 30),
                          onPressed: () {
                            _tabController.index = 0;
                            controller.selectedIndex.value = 0;
                          },
                        ),
                        Text('Home', style: TextStyle(color: Colors.blue)),
                      ],
                    ),

                    SizedBox(width: scale.getScaledWidth(40)),

                    // AddTrip button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_circle_outline_rounded, color: Colors.purple, size: 30),
                          onPressed: () {
                            _tabController.index = 1;
                            controller.selectedIndex.value = 1;
                          },
                        ),
                        Text('Add Trip', style: TextStyle(color: Colors.purple)),
                      ],
                    ),

                    SizedBox(width: scale.getScaledWidth(40)),

                    // Profile button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.person, color: Colors.green, size: 30),
                          onPressed: () {
                            _tabController.index = 2;
                            controller.selectedIndex.value = 2;
                          },
                        ),
                        Text('Profile', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final screens = [HomeScreen(), AddTripScreen(), ProfileScreen()];
}
