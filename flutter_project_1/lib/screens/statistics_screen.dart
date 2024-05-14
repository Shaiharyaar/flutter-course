import 'package:flutter/material.dart';
import 'package:flutter_project_1/util/screen_wrapper.dart';
import 'package:flutter_project_1/widgets/statistics_list.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: const SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text("Statistics", style: TextStyle(fontSize: 24)),
                  StatisticsList(),
                ]))),
      ),
    );
  }
}
