import 'dart:convert';

import 'package:dyslearn/src/app/modules/dashboard/model/dashboard_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/const/constants.dart';
import '../model/dashboard_response_data.dart';

class DashboardController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList dashboardResponseData = <DashboardResponseData>[].obs;

  Future<void> getDashboardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uuid = prefs.getString(UUID);

    debugPrint('UUID: $uuid');

    var url =
        Uri.parse('$BASE_URL/user-activities/activities/$uuid'); //for live
    //var url = Uri.parse(BASE_URL1); //for testing
    late http.Response res;

    try {
      isLoading.value = true;
      res = await http.get(url);

      final decodedBody = jsonDecode(res.body);
      debugPrint(decodedBody.toString());

      final data = DashboardResponse(
        success: decodedBody['success'],
        data: decodedBody['data'] is List
            ? (decodedBody['data'] as List)
                .map((item) => DashboardResponseData.fromJson(item))
                .toList()
            : [DashboardResponseData.fromJson(decodedBody['data'])],
      );

      if (data.success == true) {
        dashboardResponseData.value = data.data ?? [];
        isLoading.value = false;
      } else {
        debugPrint('***********');
        debugPrint('Fectching dashboard data unsuccessfully');
        debugPrint('***********');
        isLoading.value = false;
      }
    } catch (err) {
      isLoading.value = false;
      debugPrint('***********');
      debugPrint('Fectching dashboard data');
      debugPrint('Something went wrong $err');
      debugPrint('***********');
    }
  }
}
