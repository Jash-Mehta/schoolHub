// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:school_hub/main.dart';

// class AdminLoginView extends StatelessWidget {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Admin Login')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Login'),
//               onPressed: () {
//                 // Implement admin login logic here
//                 // For simplicity, we'll just navigate to the admin home
//                 Get.offAllNamed(Routes.ADMIN_HOME);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
