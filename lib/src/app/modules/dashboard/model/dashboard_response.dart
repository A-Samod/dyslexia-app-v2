import 'dashboard_response_data.dart';

class DashboardResponse {
  bool success;
  List<DashboardResponseData>? data;

  DashboardResponse({
    required this.success,
    this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> dashboardResponse) {
    return DashboardResponse(
      success: dashboardResponse['success'] ?? '',
      data: dashboardResponse['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
    };
  }
}
