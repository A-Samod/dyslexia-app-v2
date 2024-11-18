class DashboardResponseData {
  String id;
  String userId;
  int usedTime;
  int? wrongCount = 0;
  int? roundCount = 1;
  String letterOrWord;
  String writtenLetterOrWord;
  String type;
  String date;
  int v;

  DashboardResponseData({
    required this.id,
    required this.userId,
    required this.usedTime,
    this.wrongCount,
    this.roundCount,
    required this.letterOrWord,
    required this.writtenLetterOrWord,
    required this.type,
    required this.date,
    required this.v,
  });

  factory DashboardResponseData.fromJson(
      Map<String, dynamic> dashboardResponseData) {
    return DashboardResponseData(
      id: dashboardResponseData['_id'] ?? '',
      userId: dashboardResponseData['userId'] ?? '',
      usedTime: dashboardResponseData['usedTime'] ?? '',
      wrongCount: dashboardResponseData['wrongCount'],
      roundCount: dashboardResponseData['roundCount'],
      letterOrWord: dashboardResponseData['letterOrWord'] ?? '',
      writtenLetterOrWord: dashboardResponseData['writtenLetterOrWord'] ?? '',
      type: dashboardResponseData['type'] ?? '',
      date: dashboardResponseData['date'] ?? '',
      v: dashboardResponseData['__v'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'usedTime': usedTime,
      'wrongCount': wrongCount,
      'roundCount': roundCount,
      'letterOrWord': letterOrWord,
      'writtenLetterOrWord': writtenLetterOrWord,
      'type': type,
      'date': date,
      '__v': v,
    };
  }
}
