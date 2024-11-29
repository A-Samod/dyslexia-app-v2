class InstructionData {
  String id;
  String content;
  String type;

  InstructionData({
    required this.id,
    required this.content,
    required this.type,
  });

  factory InstructionData.fromJson(Map<String, dynamic> instructionData) {
    return InstructionData(
      id: instructionData['_id'] ?? '',
      content: instructionData['content'] ?? '',
      type: instructionData['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'type': type,
    };
  }
}
