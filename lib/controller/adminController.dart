import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    await _firestore.collection('students').doc(uid).update({'approved': true});
    update();
  }

  Future<void> deleteStudent(String uid) async {
    try {
      // 1. Delete student document from Firestore
      await _firestore.collection('students').doc(uid).delete();
      print('Student document deleted from Firestore');

      try {
        await _storage.ref('results/$uid').delete();
        print('Result image deleted from Storage');
      } catch (e) {
        print('No result image found for student $uid or error deleting: $e');
      }

      try {
        User? adminUser = _auth.currentUser;
        if (adminUser == null) {
          throw Exception('Admin not authenticated');
        }

        FirebaseAuth adminAuth = FirebaseAuth.instanceFor(app: _auth.app);

        await adminAuth.currentUser?.delete();
        print('User deleted from Authentication');
      } catch (authError) {
        print('Error deleting user from Authentication: $authError');
      }
    } catch (e) {
      print('Error in deleteStudent: $e');
      rethrow;
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
