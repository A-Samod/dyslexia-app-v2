class SubmitAnswerModel {
  String userId;
  String letterOrWord;
  String writtenLetterOrWord;
  String type;
  int usedTime;
  int? wrongCount;
  int? roundCount;

  SubmitAnswerModel({
    required this.userId,
    required this.letterOrWord,
    required this.writtenLetterOrWord,
    required this.type,
    required this.usedTime,
    this.wrongCount,
    this.roundCount,
  });

  factory SubmitAnswerModel.fromJson(Map<String, dynamic> submitAnswerModel) {
    return SubmitAnswerModel(
      userId: submitAnswerModel['userId'] ?? '',
      letterOrWord: submitAnswerModel['letterOrWord'] ?? '',
      writtenLetterOrWord: submitAnswerModel['writtenLetterOrWord'] ?? '',
      type: submitAnswerModel['type'] ?? '',
      usedTime: submitAnswerModel['usedTime'] ?? 0,
      wrongCount: submitAnswerModel['wrongCount'],
      roundCount: submitAnswerModel['roundCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'letterOrWord': letterOrWord,
      'writtenLetterOrWord': writtenLetterOrWord,
      'type': type,
      'usedTime': usedTime,
      'wrongCount': wrongCount,
      'roundCount': roundCount,
    };
  }
}
