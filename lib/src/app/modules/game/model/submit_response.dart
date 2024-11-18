import 'submit_response_data.dart';

class SubmitResponse {
  bool success;
  List<SubmitResponseData>? data;

  SubmitResponse({
    required this.success,
    this.data,
  });

  factory SubmitResponse.fromJson(Map<String, dynamic> submitResponse) {
    return SubmitResponse(
      success: submitResponse['success'] ?? '',
      data: submitResponse['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
    };
  }
}
