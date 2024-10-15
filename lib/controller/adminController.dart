import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> getUnapprovedStudents() async {
    QuerySnapshot snapshot = await _firestore
        .collection('students')
        .where('approved', isEqualTo: false)
        .get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> approveStudent(String uid) async {
    print("Nulll UID------------->" + uid);
    await _firestore.collection('students').doc(uid).update({'approved': true});
  }

  Future<void> deleteStudent(String uid) async {
    // Delete student document
    await _firestore.collection('students').doc(uid).delete();

    // Delete associated result image if exists
    try {
      await _storage.ref('results/$uid').delete();
    } catch (e) {
      print('No result image found for student $uid');
    }
  }

  Future<void> uploadResult(String rollNumber, String filePath) async {
    // Upload image to Firebase Storage
    String fileName = 'result_$rollNumber.jpg';
    Reference ref = _storage.ref().child('results/$fileName');
    await ref.putFile(File(filePath));

    // Get download URL
    String downloadURL = await ref.getDownloadURL();

    // Update student document with result URL
    QuerySnapshot snapshot = await _firestore
        .collection('students')
        .where('rollNumber', isEqualTo: rollNumber)
        .get();
    if (snapshot.docs.isNotEmpty) {
      await _firestore
          .collection('students')
          .doc(snapshot.docs.first.id)
          .update({
        'resultURL': downloadURL,
      });
    } else {
      throw Exception('Student with roll number $rollNumber not found');
    }
  }
}
