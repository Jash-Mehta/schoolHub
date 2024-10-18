import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _verificationId;

  Rx user = Rx(null);

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  // Future<void> sendOTP(String phoneNumber) async {
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: "+91${phoneNumber}",
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await _auth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         Get.snackbar('Error', e.message ?? 'An error occurred',
  //             backgroundColor: Colors.red, colorText: Colors.white);
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         _verificationId = verificationId;
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         _verificationId = verificationId;
  //       },
  //     );
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(),
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }

  // Future<String> verifyOTP(String otp) async {
  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId!,
  //       smsCode: otp,
  //     );

  //     UserCredential result = await _auth.signInWithCredential(credential);
  //     User? user = result.user;

  //     if (user != null) {
  //       DocumentSnapshot doc =
  //           await _firestore.collection('students').doc(user.uid).get();
  //       if (doc.exists) {
  //         bool approved = doc.get('approved') as bool;
  //         if (approved) {
  //           return 'Success';
  //         } else {
  //           await _auth.signOut();
  //           return 'Your account is not approved yet. Please contact the admin.';
  //         }
  //       } else {
  //         // If the user doesn't exist in Firestore, create a new document
  //         await _firestore.collection('students').doc(user.uid).set({
  //           'phoneNumber': user.phoneNumber,
  //           'uid': user.uid,
  //           'approved': false,
  //         });
  //         return 'Success';
  //       }
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  //   return 'An error occurred';
  // }

  Future<Map<String, dynamic>> getUserData() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('students').doc(user.value!.uid).get();
      return doc.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
    }
  }

  Future signUp({
    required String name,
    required String mobile,
    required String email,
    required String classValue,
  }) async {
    try {
      String rollNumber = await _generateUniqueRollNumber();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: mobile);
      User? user = result.user;

      if (user != null) {
        await _firestore.collection('students').doc(user.uid).set({
          'name': name,
          'mobile': mobile,
          'email': email,
          'class': classValue,
          'rollNumber': rollNumber,
          'uid': user.uid,
          'approved': false,
        });
        return 'Success';
      }
    } catch (e) {
      return e.toString();
    }
    return 'An error occurred';
  }

  Future _generateUniqueRollNumber() async {
    while (true) {
      String rollNumber =
          (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();
      var doc = await _firestore
          .collection('students')
          .where('rollNumber', isEqualTo: rollNumber)
          .get();
      if (doc.docs.isEmpty) {
        return rollNumber;
      }
    }
  }

  Future login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('students').doc(user.uid).get();
        if (doc.exists) {
          bool approved = doc.get('approved') as bool;
          if (approved) {
            return 'Success';
          } else {
            await _auth.signOut();
            return 'Your account is not approved yet. Please contact the admin.';
          }
        }
      }
    } catch (e) {
      return e.toString();
    }
    return 'Invalid email or password';
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future updateProfile({
    required String name,
    required String mobile,
    required String email,
    required String classValue,
  }) async {
    try {
      await _firestore.collection('students').doc(user.value!.uid).update({
        'name': name,
        'mobile': mobile,
        'email': email,
        'class': classValue,
      });
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future downloadResult() async {
    try {
      var doc =
          await _firestore.collection('students').doc(user.value!.uid).get();
      String? resultURL = doc.data()?['resultURL'];
      if (resultURL != null && resultURL.isNotEmpty) {
        return resultURL;
      } else {
        return 'No result URL found';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
