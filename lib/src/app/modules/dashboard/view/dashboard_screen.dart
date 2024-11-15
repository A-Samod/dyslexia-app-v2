import 'package:flutter/material.dart';

import '../widgets/summary_tab.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SummaryTab(
                  date: '2024 / 11 / 01',
                  startAt: '01.45 PM',
                  title: 'තනි අකුරු ලියමු',
                  timeToComplete: '00.45',
                  totalWrongAnswers: '3',
                  totalTrys: '5',
                ),
              ],
            ),
          ),
        ));
  }
}
