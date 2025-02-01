import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/custom_text_field.dart';
import '../../services/scaling_utils_service.dart';
import 'controller/authentication_controller.dart';

class AuthenticationScreen extends StatelessWidget {
  final AuthenticationController authController = Get.put(AuthenticationController());

  AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScalingUtility scale = ScalingUtility(context: context)
      ..setCurrentDeviceSize();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: scale.getPadding(left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: scale.getScaledHeight(60)),
                  Text('Go ahead and set up \nyour account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Fredoka',
                      )),
                  SizedBox(height: scale.getScaledHeight(5)),
                  Text('Sign in-up to enjoy the best travel companion experience',
                      style: TextStyle(
                          color: Color(0xFF5B6A7D),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Fredoka',
                      ))
                ],
              ),
            ),
            SizedBox(height: scale.getScaledHeight(10)),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: scale.getPadding(left: 28, right: 28, top: 32),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(() {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: scale.getPadding(
                                vertical: 6.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFe2e8f0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      authController.isLoginMode.value = true;
                                    },
                                    child: Container(
                                      height: scale.getScaledHeight(50),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: authController.isLoginMode.value ? Colors.white : Colors.transparent,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Fredoka',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      authController.isLoginMode.value = false;
                                    },
                                    child: Container(
                                      height: scale.getScaledHeight(50),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: !authController.isLoginMode.value ? Colors.white : Colors.transparent,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Fredoka',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: scale.getScaledHeight(12)),
                        Obx(() {
                          if (!authController.isLoginMode.value) {
                            return Padding(
                              padding: scale.getPadding(top: 20),
                              child: CustomTextField(
                                hintText: 'Name',
                                icon: const Icon(
                                  Icons.person,
                                  color: Color(0xFF2863eb),
                                ),
                                secureText: false,
                                controller: authController.nameController,
                              ),
                            );
                          }
                          return const SizedBox();
                        }),
                        SizedBox(height: scale.getScaledHeight(20)),
                        CustomTextField(
                          hintText: 'E-mail ID',
                          icon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xFF2863eb),
                          ),
                          secureText: false,
                          controller: authController.emailController,
                        ),
                        SizedBox(height: scale.getScaledHeight(20)),
                        Obx(()=> CustomTextField(
                          hintText: 'Password',
                          icon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFF2863eb),
                          ),
                          secureText: !authController.isChecked.value,
                          controller: authController.passwordController,
                        ),
                        ),
                        Obx(() {
                          if (!authController.isLoginMode.value) {
                            return Padding(
                              padding: scale.getPadding(top: 20),
                              child: CustomTextField(
                                hintText: 'Confirm Password',
                                icon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF2863eb),
                                ),
                                secureText: true,
                                controller: authController.confirmPasswordController,
                              ),
                            );
                          }
                          return const SizedBox();
                        }),
                        Obx(() {
                          return Row(
                            children: [
                              Checkbox(
                                value: authController.isChecked.value,
                                onChanged: (value) {
                                  authController.isChecked.value = value!;
                                },
                              ),
                              const Text('Show Password'),
                            ],
                          );
                        }),
                        InkWell(
                          onTap: () {
                            if (authController.isLoginMode.value) {
                              authController.loginUser(context);
                            } else {
                              authController.signUpUser(context);
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: scale.getPadding(vertical: 13.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2863eb),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Obx(()=> Text(
                                authController.isLoginMode.value ? "Login" : "Register",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Fredoka',
                                ),
                               ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: scale.getScaledHeight(25)),
                        Row(
                          children: [
                            const Expanded(child: Divider(color: Color(0xFF8190a4), thickness: 1)),
                            const SizedBox(width: 10),
                            const Text(
                              'Or login with',
                              style: TextStyle(color: Color(0xFF8190a4),fontFamily: 'Fredoka',fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(child: Divider(color: Color(0xFF8190a4), thickness: 1)),
                          ],
                        ),
                        SizedBox(height: scale.getScaledHeight(20)),
                        Padding(
                          padding: scale.getPadding(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: scale.getScaledHeight(50),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF8190a4)),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/google_logo.png',
                                        height: scale.getScaledHeight(25),
                                        width: scale.getScaledWidth(25),
                                      ),
                                      SizedBox(width: scale.getScaledWidth(5)),
                                      Text('Google',style: TextStyle(fontSize: 16,fontFamily: 'Fredoka'),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: scale.getScaledWidth(20)),
                              Expanded(
                                child: Container(
                                  height: scale.getScaledHeight(50),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF8190a4)),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/apple_logo.png',
                                        height: scale.getScaledHeight(22),
                                        width: scale.getScaledWidth(22),
                                      ),
                                      SizedBox(width: scale.getScaledWidth(5)),
                                      Text('Apple',style: TextStyle(fontSize: 16,fontFamily: 'Fredoka'),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}