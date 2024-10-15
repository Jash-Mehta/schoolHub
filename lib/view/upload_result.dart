import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../controller/adminController.dart';

class UploadResultView extends GetView<AdminController> {
  final TextEditingController rollNumberController = TextEditingController();
  final RxString filePath = ''.obs;
  final RxBool isUploading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Result',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
                Icon(Icons.upload_file, size: 80, color: Colors.white),
                SizedBox(height: 24),
                Text(
                  'Upload Student Result',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                _buildTextField(
                    rollNumberController, 'Roll Number', Icons.assignment_ind),
                SizedBox(height: 24),
                _buildFileSelectionButton(),
                SizedBox(height: 16),
                Obx(() => filePath.value.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.description,
                                color: Colors.blue.shade800),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Selected file: ${filePath.value.split('/').last}',
                                style: TextStyle(color: Colors.blue.shade800),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()),
                SizedBox(height: 32),
                _buildUploadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
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
      ),
    );
  }

  Widget _buildFileSelectionButton() {
    return ElevatedButton.icon(
      icon: Icon(Icons.attach_file, color: Colors.blue.shade800),
      label: Text('Select Result File',
          style: TextStyle(color: Colors.blue.shade800)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          filePath.value = result.files.single.path!;
        }
      },
    );
  }

  Widget _buildUploadButton() {
    return Obx(() => ElevatedButton.icon(
          icon: isUploading.value
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                      color: Colors.blue.shade800, strokeWidth: 2),
                )
              : Icon(Icons.cloud_upload, color: Colors.blue.shade800),
          label: Text(
            isUploading.value ? 'Uploading...' : 'Upload Result',
            style: TextStyle(color: Colors.blue.shade800),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: isUploading.value
              ? null
              : () async {
                  if (rollNumberController.text.isEmpty) {
                    Get.snackbar('Error', 'Please enter a roll number',
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (filePath.value.isEmpty) {
                    Get.snackbar('Error', 'Please select a file',
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  isUploading.value = true;
                  try {
                    await controller.uploadResult(
                        rollNumberController.text, filePath.value);
                    Get.snackbar('Success', 'Result uploaded successfully',
                        backgroundColor: Colors.green, colorText: Colors.white);
                    rollNumberController.clear();
                    filePath.value = '';
                  } catch (e) {
                    Get.snackbar('Error', e.toString(),
                        backgroundColor: Colors.red, colorText: Colors.white);
                  } finally {
                    isUploading.value = false;
                  }
                },
        ));
  }
}
