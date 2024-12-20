import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummaryTab extends StatelessWidget {
  const SummaryTab({
    super.key,
    required this.date,
    required this.type,
    required this.title,
    required this.timeToComplete,
    required this.totalWrongAnswers,
    required this.writtenLetterOrWord,
    required this.totalTrys,
  });

  final String date;
  final String type;
  final String title;
  final String timeToComplete;
  final String totalWrongAnswers;
  final String totalTrys;
  final String writtenLetterOrWord;

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
                flex: 1,
                child: Text("දිනය"),
              ),
              const SizedBox(width: 240),
              Expanded(
                flex: 1,
                child:
                    Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(date))),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Text('$startAt Seconds'),
              // ),
            ],
          ),
          const SizedBox(height: 10),
          type == 'single'
              ? Text(
                  '$title අකුර ලියන්න',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                )
              : Text(
                  '$title වචනෙ ලියන්න',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
          const SizedBox(height: 10),
          // Text(
          //         '$writtenLetterOrWord අකුර2 ලියන්න',
          //         style: const TextStyle(
          //           fontWeight: FontWeight.w500,
          //           fontSize: 18,
          //         ),
          //       ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("ලියන ලද අකුර/වචනය"),
                  Text(writtenLetterOrWord),
                ],
              ),
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
