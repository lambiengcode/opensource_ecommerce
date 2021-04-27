import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/widgets/line_chart.dart';
import 'package:van_transport/src/widgets/pie_chart.dart';

class RevenuePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  String type = 'All';
  List<String> types = [
    'Statistic by last 7 days',
    'Statistic by last 3 month',
    'Statistic by last year',
  ];

  @override
  void initState() {
    super.initState();
    type = types[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mC,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 6.0),
              decoration: BoxDecoration(
                color: mC,
                boxShadow: [
                  BoxShadow(
                    color: mCD,
                    offset: Offset(10, 10),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  icon: Icon(
                    Feather.list,
                    size: width / 16.0,
                    color: colorTitle,
                  ),
                  iconEnabledColor: Colors.grey.shade800,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: type,
                  items: types.map((title) {
                    return DropdownMenuItem(
                        value: title,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: width / 26.0,
                            color: colorTitle,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Lato',
                          ),
                        ));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      type = val;
                    });
                  },
                ),
              ),
            ),
            Divider(
              color: fCL,
              thickness: .1,
              height: .1,
            ),
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
