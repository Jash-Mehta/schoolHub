import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/adminController.dart';

class StudentApprovalView extends GetView<AdminController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Approval',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: controller.getUnapprovedStudents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text('No unapproved students',
                      style: TextStyle(color: Colors.white, fontSize: 18)));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var student = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(student['name'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Roll Number: ${student['rollNumber']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check_circle, color: Colors.green),
                          onPressed: () async {
                            await controller.approveStudent(student['uid']);
                            Get.snackbar('Success', 'Student approved',
                                backgroundColor: Colors.green,
                                colorText: Colors.white);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: () async {
                            await controller.deleteStudent(student['uid']);
                            Get.snackbar('Success', 'Student deleted',
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
