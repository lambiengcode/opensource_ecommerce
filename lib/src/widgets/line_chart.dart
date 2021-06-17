import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:van_transport/src/common/style.dart';

class LineChartRevenue extends StatefulWidget {
  final List<double> data;
  LineChartRevenue({@required this.data});
  @override
  State<StatefulWidget> createState() => LineChartRevenueState();
}

class LineChartRevenueState extends State<LineChartRevenue> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
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
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 37,
                ),
                Text(
                  'Statistic Van Transport',
                  style: TextStyle(
                    color: colorDarkGrey,
                    fontSize: width / 24.0,
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.data.length == 7
                      ? 'Đơn hàng trong 7 ngày qua'
                      : widget.data.length == 3
                          ? 'Đơn hàng trong 3 tháng qua'
                          : 'Đơn hàng trong 12 tháng qua',
                  style: TextStyle(
                    color: colorTitle,
                    fontSize: width / 23.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      sampleData1(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Feather.bar_chart_2,
                color: colorTitle,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: mC,
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => TextStyle(
            color: colorTitle,
            fontWeight: FontWeight.w600,
            fontSize: width / 32.0,
            fontFamily: 'Lato',
          ),
          margin: 10,
          getTitles: (value) {
            if (widget.data.length == 7) {
              switch (value.toInt()) {
                case 1:
                  return DateTime.now()
                      .subtract(Duration(days: 6))
                      .day
                      .toString();
                case 3:
                  return DateTime.now()
                      .subtract(Duration(days: 5))
                      .day
                      .toString();
                case 5:
                  return DateTime.now()
                      .subtract(Duration(days: 4))
                      .day
                      .toString();
                case 7:
                  return DateTime.now()
                      .subtract(Duration(days: 3))
                      .day
                      .toString();
                case 9:
                  return DateTime.now()
                      .subtract(Duration(days: 2))
                      .day
                      .toString();
                case 11:
                  return DateTime.now()
                      .subtract(Duration(days: 1))
                      .day
                      .toString();
                case 13:
                  return DateTime.now().day.toString();
              }
              return '';
            } else if (widget.data.length == 3) {
              switch (value.toInt()) {
                case 2:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 2)));

                case 7:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30)));

                case 12:
                  return DateFormat('MMM').format(DateTime.now());
              }
              return '';
            } else {
              switch (value.toInt()) {
                case 1:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 11)));
                case 4:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 10)));
                case 7:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 9)));
                case 10:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 8)));
                case 13:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 7)));
                case 16:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 6)));
                case 19:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 5)));
                case 22:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 4)));
                case 25:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 3)));
                case 28:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30 * 2)));
                case 31:
                  return DateFormat('MMM')
                      .format(DateTime.now().subtract(Duration(days: 30)));
                case 34:
                  return DateFormat('MMM').format(DateTime.now());
              }
              return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'Lato',
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 5:
                return '5';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: .5,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: widget.data.length == 12 ? 36 : 14,
      maxY: 30,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: widget.data.length == 7
          ? [
              FlSpot(1, widget.data[0]),
              FlSpot(3, widget.data[1]),
              FlSpot(5, widget.data[2]),
              FlSpot(7, widget.data[3]),
              FlSpot(9, widget.data[4]),
              FlSpot(11, widget.data[5]),
              FlSpot(13, widget.data[6]),
            ]
          : widget.data.length == 3
              ? [
                  FlSpot(2, widget.data[0]),
                  FlSpot(7, widget.data[1]),
                  FlSpot(12, widget.data[2]),
                ]
              : [
                  FlSpot(1, widget.data[0]),
                  FlSpot(4, widget.data[1]),
                  FlSpot(7, widget.data[2]),
                  FlSpot(10, widget.data[3]),
                  FlSpot(13, widget.data[4]),
                  FlSpot(16, widget.data[5]),
                  FlSpot(19, widget.data[6]),
                  FlSpot(22, widget.data[7]),
                  FlSpot(25, widget.data[8]),
                  FlSpot(28, widget.data[9]),
                  FlSpot(31, widget.data[10]),
                  FlSpot(34, widget.data[11]),
                ],
      isCurved: true,
      colors: [
        colorPrimary,
      ],
      barWidth: 1.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    // final LineChartBarData lineChartBarData2 = LineChartBarData(
    //   spots: [
    //     FlSpot(1, 1),
    //     FlSpot(3, 2.8),
    //     FlSpot(7, 1.2),
    //     FlSpot(10, 2.8),
    //     FlSpot(12, 2.6),
    //     FlSpot(13, 3.9),
    //   ],
    //   isCurved: true,
    //   colors: [
    //     const Color(0xffaa4cfc),
    //   ],
    //   barWidth: 1.5,
    //   isStrokeCapRound: true,
    //   dotData: FlDotData(
    //     show: false,
    //   ),
    //   belowBarData: BarAreaData(show: false, colors: [
    //     const Color(0x00aa4cfc),
    //   ]),
    // );
    // final LineChartBarData lineChartBarData3 = LineChartBarData(
    //   spots: [
    //     FlSpot(1, 2.8),
    //     FlSpot(3, 1.9),
    //     FlSpot(6, 3),
    //     FlSpot(10, 1.3),
    //     FlSpot(13, 2.5),
    //   ],
    //   isCurved: true,
    //   colors: const [
    //     Color(0xff27b6fc),
    //   ],
    //   barWidth: 1.5,
    //   isStrokeCapRound: true,
    //   dotData: FlDotData(
    //     show: false,
    //   ),
    //   belowBarData: BarAreaData(
    //     show: false,
    //   ),
    // );
    return [
      lineChartBarData1,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'FEB';
              case 7:
                return 'MAR';
              case 12:
                return 'APR';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
