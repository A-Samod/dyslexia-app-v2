import 'instruction_data.dart';

class InstructionResponse {
  bool success;
  List<InstructionData>? data;

  InstructionResponse({
    required this.success,
    this.data,
  });

  factory InstructionResponse.fromJson(
      Map<String, dynamic> instructionResponse) {
    return InstructionResponse(
      success: instructionResponse['success'] ?? '',
      data: instructionResponse['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
    };
  }
}
