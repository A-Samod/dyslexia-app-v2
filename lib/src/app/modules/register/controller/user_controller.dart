// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/const/constants.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxString uuid = "".obs;
  final RxString userName = "".obs;
  final RxString email = "".obs;
  final RxBool isLoading = false.obs;

  //--------------Add new user
  Future<void> addUser(
    BuildContext context,
    String userName,
    String email,
  ) async {
    try {
      await _firestore.collection('user').add({
        'userName': userName,
        'email': email,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('User added successfully'),
          closeIconColor: Colors.white,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  //-------Get user id and store email
  Future<void> getUserId(BuildContext context, email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(EMAIL, email);

    //get user id
    final QuerySnapshot querySnapshot = await _firestore
        .collection('user')
        .where('email', isEqualTo: email)
        .get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;
    final String userId = documents[0].id;
    final String userName = documents[0]['userName'];
    await prefs.setString(UUID, userId);
    await prefs.setString(USER_NAME, userName);
  }
}
