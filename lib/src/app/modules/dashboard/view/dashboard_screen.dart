import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';
import '../widgets/summary_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    dashboardController.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ප්‍රගති පුවරුව'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Obx(() {
            if (dashboardController.isLoading.value) {
              return const CircularProgressIndicator();
            }

            if (dashboardController.dashboardResponseData.isEmpty) {
              return const Text('No data available');
            }

            return Expanded(
              child: ListView.builder(
                itemCount: dashboardController.dashboardResponseData.length,
                itemBuilder: (context, index) {
                  final data = dashboardController.dashboardResponseData[index];
                  return Column(
                    children: [
                      SummaryTab(
                        date: data.date ?? 'N/A',
                        type: data.type,
                        title: data.letterOrWord ?? 'N/A',
                        writtenLetterOrWord: data.writtenLetterOrWord ?? 'N/A',
                        timeToComplete: data.usedTime.toString(),
                        totalWrongAnswers: data.wrongCount?.toString() ?? '0',
                        totalTrys: data.roundCount?.toString() ?? '0',
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
