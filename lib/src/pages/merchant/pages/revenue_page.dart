import 'package:flutter/material.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/widgets/line_chart.dart';
import 'package:van_transport/src/widgets/pie_chart.dart';

class RevenuePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mC,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: LineChartRevenue(),
              ),
            ),
            Divider(
              color: colorDarkGrey,
              thickness: 1,
              height: 1,
            ),
            Expanded(
              child: Container(
                child: PieChartRevenue(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
