import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_hub/main.dart';

class AdminHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
      ),
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
                Icon(Icons.admin_panel_settings, size: 80, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  'Welcome, Admin',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                _buildAdminButton(
                  icon: Icons.person_add,
                  label: 'Student Approval',
                  onPressed: () => Get.toNamed(Routes.STUDENT_APPROVAL),
                ),
                SizedBox(height: 20),
                _buildAdminButton(
                  icon: Icons.upload_file,
                  label: 'Upload Result',
                  onPressed: () => Get.toNamed(Routes.UPLOAD_RESULT),
                ),
                SizedBox(height: 20),
                _buildAdminButton(
                  icon: Icons.analytics,
                  label: 'View Statistics',
                  onPressed: () {
                    // TODO: Implement statistics view
                    Get.snackbar('Coming Soon', 'Statistics feature is under development',
                        backgroundColor: Colors.orange, colorText: Colors.white);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdminButton({required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.blue.shade800),
      label: Text(label, style: TextStyle(color: Colors.blue.shade800)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: Size(250, 60),
      ),
    );
  }
}