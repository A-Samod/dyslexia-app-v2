import 'package:flutter/material.dart';

class SummaryTab extends StatelessWidget {
  const SummaryTab({
    super.key,
    required this.date,
    required this.startAt,
    required this.title,
    required this.timeToComplete,
    required this.totalWrongAnswers,
    required this.totalTrys,
  });

  final String date;
  final String startAt;
  final String title;
  final String timeToComplete;
  final String totalWrongAnswers;
  final String totalTrys;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                flex: 2,
                child: Text("දිනය"),
              ),
              const SizedBox(width: 50),
              Expanded(
                flex: 2,
                child: Text(date),
              ),
              Expanded(
                flex: 1,
                child: Text(startAt),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("කාලය"),
                  Text(timeToComplete),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("වැරදි ගණන"),
                  Text(totalWrongAnswers),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("වාර ගණන"),
                  Text(totalTrys),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
