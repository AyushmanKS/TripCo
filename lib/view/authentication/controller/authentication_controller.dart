import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_companion/components/navigation_menu.dart';

class AuthenticationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  RxBool isChecked = false.obs;
  RxBool isLoginMode = true.obs;

  _setUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserLoggedIn', true);
  }

  Future<void> loginUser(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password cannot be empty.");
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Get.to(NavigationMenu());
        _setUserLoggedIn();
      } else {
        Get.snackbar("Error", "User authentication failed. Please try again.");
      }
    } catch (e) {
      _handleAuthError(e);
    }
  }

  Future<void> signUpUser(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String name = nameController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match.");
      return;
    }

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty) {
      Get.snackbar("Error", "Email, passwords, and name cannot be empty.");
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        await FirebaseDatabase.instance.ref("users/$uid").set({
          "email": email,
          "name": name,
          "createdAt": DateTime.now().toIso8601String(),
        });

        Get.snackbar("Success", "User registered successfully.");
        Get.to(NavigationMenu());
        _setUserLoggedIn();
      } else {
        Get.snackbar("Error", "User registration failed. Please try again.");
      }
    } catch (e) {
      _handleAuthError(e);
    }
  }

  void _handleAuthError(dynamic e) {
    String errorMessage = "An error occurred";

    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          errorMessage = "The email address is invalid.";
          break;
        case 'user-disabled':
          errorMessage = "This user has been disabled.";
          break;
        case 'user-not-found':
          errorMessage = "No user found for this email.";
          break;
        case 'wrong-password':
          errorMessage = "Wrong password provided.";
          break;
        case 'email-already-in-use':
          errorMessage = "The email address is already in use.";
          break;
        case 'weak-password':
          errorMessage = "The password is too weak.";
          break;
        default:
          errorMessage = "An unknown error occurred.";
      }
    } else {
      errorMessage = "An error occurred: ${e.toString()}";
    }

    Get.snackbar("Error", errorMessage);
  }
}
