import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_hub/controller/authcontroller.dart';
import 'package:school_hub/main.dart';

class HomeView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Portal', style: TextStyle(fontWeight: FontWeight.bold)),
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
                Text(
                  'Welcome to Student Portal',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 40),
                _buildButton(
                  icon: Icons.edit,
                  label: 'Edit Profile',
                  onPressed: () => Get.toNamed(Routes.STUDENT_PROFILE),
                ),
                SizedBox(height: 20),
                _buildButton(
                  icon: Icons.download,
                  label: 'Download Result',
                  onPressed: () async {
                    String? resultURL = await controller.downloadResult();
                    if (resultURL != null && resultURL.startsWith('http')) {
                      Get.to(() => ResultView(resultURL: resultURL));
                    } else {
                      Get.snackbar('Error', resultURL ?? 'Failed to download result',
                          backgroundColor: Colors.red, colorText: Colors.white);
                    }
                  },
                ),
                SizedBox(height: 20),
                _buildButton(
                  icon: Icons.logout,
                  label: 'Logout',
                  onPressed: () async {
                    await controller.signOut();
                    Get.offAllNamed(Routes.STUDENT_LOGIN);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.blue.shade800),
      label: Text(label, style: TextStyle(color: Colors.blue.shade800)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

class ResultView extends StatelessWidget {
  final String resultURL;

  ResultView({required this.resultURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Result', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade200],
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                resultURL,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 48),
                        SizedBox(height: 16),
                        Text('Error loading image', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}