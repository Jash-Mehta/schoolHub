// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:school_hub/controller/authcontroller.dart';
// import 'package:school_hub/main.dart';

// class OTPVerificationView extends GetView<AuthController> {
//   final TextEditingController otpController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final String phoneNumber = Get.arguments as String;

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue.shade800, Colors.blue.shade200],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Icon(Icons.lock_outline, size: 80, color: Colors.white),
//                   SizedBox(height: 24),
//                   Text(
//                     'OTP Verification',
//                     style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Enter the OTP sent to $phoneNumber',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 48),
//                   _buildTextField(otpController, 'Enter OTP', Icons.confirmation_number,
//                       keyboardType: TextInputType.number),
//                   SizedBox(height: 24),
//                   ElevatedButton(
//                     child: Text('Verify OTP', style: TextStyle(fontSize: 18)),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.blue.shade800,
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                     onPressed: () async {
//                       String result = await controller.verifyOTP(otpController.text);
//                       if (result == 'Success') {
//                         Get.offAllNamed(Routes.STUDENT_HOME);
//                       } else {
//                         Get.snackbar('Error', result,
//                             backgroundColor: Colors.red,
//                             colorText: Colors.white);
//                       }
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   TextButton(
//                     child: Text('Resend OTP',
//                         style: TextStyle(color: Colors.white)),
//                     onPressed: () async {
//                       await controller.sendOTP(phoneNumber);
//                       Get.snackbar('OTP Sent', 'A new OTP has been sent to your phone number.',
//                           backgroundColor: Colors.green,
//                           colorText: Colors.white);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//       TextEditingController controller, String label, IconData icon,
//       {TextInputType? keyboardType, bool obscureText = false}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: Colors.blue.shade800),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         ),
//         keyboardType: keyboardType,
//       ),
//     );
//   }
// }