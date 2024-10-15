import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_hub/main.dart';

class RoleSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, size: 100, color: Colors.white),
                SizedBox(height: 40),
                Text(
                  'Welcome to School Hub',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Select your role',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 60),
                _buildRoleButton(
                  icon: Icons.person,
                  label: 'Continue as Student',
                  onPressed: () => Get.toNamed(Routes.STUDENT_LOGIN),
                ),
                SizedBox(height: 20),
                _buildRoleButton(
                  icon: Icons.admin_panel_settings,
                  label: 'Continue as Admin',
                  onPressed: () => Get.toNamed(Routes.ADMIN_HOME),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.blue.shade800),
      label: Text(label, style: TextStyle(color: Colors.blue.shade800)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: Size(250, 60),
      ),
      onPressed: onPressed,
    );
  }
}