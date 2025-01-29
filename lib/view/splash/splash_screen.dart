import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:travel_companion/routes/app_routes.dart';
import 'package:travel_companion/view/splash/controller/splash_controller.dart';
import '../../services/scaling_utils_service.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: splashController.imgList.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.3),
                  BlendMode.darken,
                ),
                child: Image.asset(
                  splashController.imgList[index],
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              height: double.infinity,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
            ),
          ),
          Padding(
            padding: scale.getPadding(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: scale.getScaledHeight(20)),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Trip',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Co',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: scale.getScaledHeight(20)),
                Text(
                  'Discover Destination, Create Memories!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF82d8f1),
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Container()),
                Padding(
                  padding: scale.getPadding(horizontal: 20, vertical: 40),
                  child: Container(
                    width: double.infinity,
                    height: scale.getScaledHeight(50),
                    margin: scale.getMargin(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.authenticationScreen);
                      },
                      child: Text(
                        'Sign In / Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
