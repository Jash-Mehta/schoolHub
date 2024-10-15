import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_hub/controller/authcontroller.dart';

class ProfileView extends GetView<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController classController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Pre-fill the data
    nameController.text = controller.user.value?.displayName ?? '';
    mobileController.text = controller.user.value?.phoneNumber ?? '';
    emailController.text = controller.user.value?.email ?? '';
    controller.getUserData().then((userData) {
      classController.text = userData['class'] ?? '';
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade200],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.person, size: 80, color: Colors.white),
                  SizedBox(height: 24),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48),
                  _buildTextField(nameController, 'Name', Icons.person),
                  SizedBox(height: 16),
                  _buildTextField(
                      mobileController, 'Mobile Number', Icons.phone,
                      keyboardType: TextInputType.phone),
                  SizedBox(height: 16),
                  _buildTextField(emailController, 'Email', Icons.email,
                      keyboardType: TextInputType.emailAddress),
                  SizedBox(height: 16),
                  _buildTextField(classController, 'Class', Icons.school),
                  SizedBox(height: 24),
                  ElevatedButton(
                    child:
                        Text('Update Profile', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      String result = await controller.updateProfile(
                        name: nameController.text,
                        mobile: mobileController.text,
                        email: emailController.text,
                        classValue: classController.text,
                      );
                      if (result == 'Success') {
                        Get.back();
                        Get.snackbar('Success', 'Profile updated successfully',
                            backgroundColor: Colors.green,
                            colorText: Colors.white);
                      } else {
                        Get.snackbar('Error', result,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white)),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue.shade800),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
