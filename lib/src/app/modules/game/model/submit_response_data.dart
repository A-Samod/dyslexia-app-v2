class SubmitResponseData {
  String id;
  String userId;
  String letterOrWord;
  String type;
  int? usedTime;
  int? wrongCount;
  int? roundCount;
  String date;
  int? v;

  SubmitResponseData({
    required this.id,
    required this.userId,
    required this.letterOrWord,
    required this.type,
    required this.usedTime,
    this.wrongCount,
    this.roundCount,
    required this.date,
    required this.v,
  });

  factory SubmitResponseData.fromJson(Map<String, dynamic> submitResponseData) {
    return SubmitResponseData(
      id: submitResponseData['_id'] ?? '',
      userId: submitResponseData['userId'] ?? '',
      letterOrWord: submitResponseData['letterOrWord'] ?? '',
      type: submitResponseData['type'] ?? '',
      usedTime: submitResponseData['usedTime'] ?? '',
      wrongCount: submitResponseData['wrongCount'],
      roundCount: submitResponseData['roundCount'],
      date: submitResponseData['date'] ?? '',
      v: submitResponseData['__v'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'letterOrWord': letterOrWord,
      'type': type,
      'usedTime': usedTime,
      'wrongCount': wrongCount,
      'roundCount': roundCount,
      'date': date,
      '__v': v,
    };
  }
}
