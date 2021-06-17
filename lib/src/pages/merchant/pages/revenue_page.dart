import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/merchant/controllers/merchant_controller.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';
import 'package:van_transport/src/widgets/line_chart.dart';

class RevenuePage extends StatefulWidget {
  final String comeFrom;
  RevenuePage({this.comeFrom = 'MERCHANT'});
  @override
  State<StatefulWidget> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  final transportController = Get.put(TransportController());
  final merchantController = Get.put(MerchantController());
  String type = '';
  List<String> types = [
    'Thống kê 7 ngày gần nhất',
    'Thống kê 3 tháng gần nhất',
    'Thống kê 12 tháng gần nhất',
  ];

  @override
  void initState() {
    super.initState();
    type = types[0];
    if (widget.comeFrom == 'TRANSPORT') {
      transportController.getStatistic('7', 'daily');
    } else {
      merchantController.getStatistic('7', 'daily');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    if (type == types[0]) {
                      if (widget.comeFrom == 'TRANSPORT') {
                        transportController.getStatistic('7', 'daily');
                      } else {
                        merchantController.getStatistic('7', 'daily');
                      }
                    } else if (type == types[1]) {
                      if (widget.comeFrom == 'TRANSPORT') {
                        transportController.getStatistic('3', 'month');
                      } else {
                        merchantController.getStatistic('3', 'month');
                      }
                    } else {
                      if (widget.comeFrom == 'TRANSPORT') {
                        transportController.getStatistic('12', 'month');
                      } else {
                        merchantController.getStatistic('12', 'month');
                      }
                    }
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
              child: StreamBuilder(
                stream: widget.comeFrom == 'TRANSPORT'
                    ? transportController.getStatisticStream
                    : merchantController.getStatisticStream,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  print(snapshot.data);

                  List<double> listDoubleLine = [];
                  List<double> listDoublePie = [];
                  for (int i = 0; i < snapshot.data['lineChart'].length; i++) {
                    listDoubleLine.add(double.tryParse(
                        snapshot.data['lineChart'][i].toString()));
                    if (snapshot.data['pieChart'][i].toString() == '0.00') {
                      listDoublePie.add(.3);
                    } else {
                      listDoublePie.add(double.tryParse(
                          snapshot.data['pieChart'][i].toString()));
                    }
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: LineChartRevenue(
                            data: listDoubleLine,
                          ),
                        ),
                      ),
                      // Divider(
                      //   color: colorDarkGrey,
                      //   thickness: 1,
                      //   height: 1,
                      // ),
                      // Expanded(
                      //   child: Container(
                      //       // child: PieChartRevenue(
                      //       //   data: listDoublePie,
                      //       // ),
                      //       ),
                      // ),
                      Expanded(
                        child: Container(
                          height: width * .65,
                          width: width * .65,
                          child: Lottie.asset('assets/lottie/splash.json'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
