import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/const/constants.dart';
import '../model/instruction_data.dart';
import '../model/instruction_response.dart';

class GameController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList instructionsData = <InstructionData>[].obs;

  Future<void> fetchGameInstructions(String gameMode) async {
    var url = Uri.parse('$BASE_URL/letters/$gameMode');
    late http.Response res;

    try {
      isLoading.value = true;
      res = await http.get(url);

      final data = InstructionResponse(
        success: jsonDecode(res.body)['success'],
        data: (jsonDecode(res.body)['data'] as List)
            .map((item) => InstructionData.fromJson(item))
            .toList(),
      );

      if (data.success == true) {
        instructionsData.value = data.data ?? [];
        isLoading.value = false;
      } else {
        debugPrint('***********');
        debugPrint('Fectching game instructions unsuccessfully');
        debugPrint('***********');
        isLoading.value = false;
      }
    } catch (err) {
      isLoading.value = false;
      debugPrint('***********');
      debugPrint('Fectching game instructions');
      debugPrint('Something went wrong $err');
      debugPrint('***********');
    }
  }
}
