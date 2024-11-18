import 'dart:convert';

import '../model/submit_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/const/constants.dart';
import '../model/instruction_data.dart';
import '../model/instruction_response.dart';
import '../model/submit_answer_model.dart';
import '../model/submit_response_data.dart';

class GameController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList instructionsData = <InstructionData>[].obs;
  final RxList submitResponseData = <SubmitResponseData>[].obs;

  Future<void> fetchGameInstructions(String gameMode) async {
    instructionsData.clear();
    var url = Uri.parse('$BASE_URL/letters/$gameMode'); //for live
    //var url = Uri.parse(BASE_URL); //for testing
    late http.Response res;

    try {
      isLoading.value = true;
      res = await http.get(url);

      final decodedBody = jsonDecode(res.body);
      debugPrint(decodedBody.toString());

      final data = InstructionResponse(
        success: decodedBody['success'],
        data: decodedBody['data'] is List
            ? (decodedBody['data'] as List)
                .map((item) => InstructionData.fromJson(item))
                .toList()
            : [InstructionData.fromJson(decodedBody['data'])],
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
      //isLoading.value = false;
      debugPrint('***********');
      debugPrint('Fectching game instructions');
      debugPrint('Something went wrong $err');
      debugPrint('***********');
    }
  }

  Future<void> submitAnswer(
    BuildContext context,
    SubmitAnswerModel submitData,
  ) async {
    isLoading.value = true;
    //debugPrint(' ============== user id: ${json.encode(submitData.toJson())} ==============');
    var url = Uri.parse('$BASE_URL/user-activities/submit');
    late http.Response res;

    try {
      //   final body = json.encode({
      //   "userId": "pUZXK5VzDp2NBspNBp4o",
      //   "letterOrWord": "අ",
      //   "writtenLetterOrWord": "අ",
      //   "type": "single",
      //   "usedTime": 10,
      //   "wrongCount": 2,
      //   "roundCount": 1
      // });

      //res = await http.post(url, body: json.encode(submitData.toJson()));

//       res = await http.post(url, body: {
//   "userId": "pUZXK5VzDp2NBspNBp4o",
//   "letterOrWord": "අ",
//   "writtenLetterOrWord":"අ",
//   "type": "single",
//   "usedTime": 10,
//   "wrongCount": 2,
//   "roundCount": 1
// });

      res = await http.post(
        url,
        headers: {
          "Content-Type": "application/json"
        }, // Set content type to JSON
        body: json.encode(submitData.toJson()),
      );
      //submitData.toJson());
      final decodedBody = jsonDecode(res.body);
      debugPrint('>>>>>>> ${decodedBody.toString()}');

      if (res.statusCode == 200) {
        isLoading.value = false;
        final data = SubmitResponse(
          success: decodedBody['success'],
          data: decodedBody['data'] is List
              ? (decodedBody['data'] as List)
                  .map((item) => SubmitResponseData.fromJson(item))
                  .toList()
              : [SubmitResponseData.fromJson(decodedBody['data'])],
        );

        if (data.success == true) {
          submitResponseData.value = data.data ?? [];
        } else {
          debugPrint('Error: Submit response was unsuccessful.');
        }
      } else {
        debugPrint('Error: Server returned status code ${res.statusCode}');
      }
    } catch (err) {
      isLoading.value = false;
      debugPrint('***********');
      debugPrint('Submit answer');
      debugPrint('Something went wrong $err');
      debugPrint('***********');
    }
  }
}
