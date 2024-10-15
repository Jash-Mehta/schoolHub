import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_hub/controller/authcontroller.dart';
import 'package:school_hub/main.dart';

class SignupView extends GetView<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController classController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade200],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Text(
                  'Create Your Account',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                _buildTextField(nameController, 'Name', Icons.person),
                SizedBox(height: 16),
                _buildTextField(mobileController, 'Mobile Number', Icons.phone,
                    keyboardType: TextInputType.phone),
                SizedBox(height: 16),
                _buildTextField(emailController, 'Email', Icons.email,
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: 16),
                _buildTextField(classController, 'Class', Icons.school),
                SizedBox(height: 32),
                ElevatedButton(
                  child: Text('Sign Up', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    //  onPrimary: Colors.blue.shade800,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () async {
                    String result = await controller.signUp(
                      name: nameController.text,
                      mobile: mobileController.text,
                      email: emailController.text,
                      classValue: classController.text,
                    );
                    if (result == 'Success') {
                      Get.offAllNamed(Routes.STUDENT_HOME);
                    } else {
                      Get.snackbar('Error', result,
                          backgroundColor: Colors.red, colorText: Colors.white);
                    }
                  },
                ),
              ],
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
