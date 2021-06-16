import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:van_transport/src/common/style.dart';

class DrawerAddress extends StatefulWidget {
  final data;
  DrawerAddress({@required this.data});
  @override
  State<StatefulWidget> createState() => _DrawerAddressState();
}

class _DrawerAddressState extends State<DrawerAddress> {
  @override
  void initState() {
    super.initState();
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height / 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Feather.x,
                  color: colorTitle,
                  size: width / 18.0,
                ),
                onPressed: () => Get.back(),
              ),
              Padding(
                padding: EdgeInsets.only(right: width * .12),
                child: Text(
                  'Thông tin địa chỉ',
                  style: TextStyle(
                    color: colorPrimary,
                    fontFamily: 'Lato',
                    fontSize: width / 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '',
                style: TextStyle(
                  color: colorTitle,
                  fontFamily: 'Lato',
                  fontSize: width / 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Tên người nhận:\t',
                    style: TextStyle(
                      fontSize: width / 24.0,
                      fontFamily: 'Lato',
                      color: colorTitle,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.data['recipient']['name']}',
                    style: TextStyle(
                      fontSize: width / 26.0,
                      fontFamily: 'Lato',
                      color: colorTitle,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Địa chỉ nhận hàng:\t',
                    style: TextStyle(
                      fontSize: width / 24.0,
                      fontFamily: 'Lato',
                      color: colorTitle,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.data['recipient']['location']['address']}',
                    style: TextStyle(
                      fontSize: width / 26.0,
                      fontFamily: 'Lato',
                      color: colorTitle,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Số điện thoại người nhận:\n',
                    style: TextStyle(
                      fontSize: width / 24.0,
                      fontFamily: 'Lato',
                      color: colorTitle,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.data['recipient']['phone']}',
                    style: TextStyle(
                      fontSize: width / 26.0,
                      fontFamily: 'Lato',
                      color: colorTitle,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Divider(
              color: colorDarkGrey,
              thickness: .2,
              height: .2,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Tên người gửi:\t',
                        style: TextStyle(
                          fontSize: width / 24.0,
                          fontFamily: 'Lato',
                          color: colorTitle,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '${widget.data['sender']['name']}',
                        style: TextStyle(
                          fontSize: width / 26.0,
                          fontFamily: 'Lato',
                          color: colorTitle,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Địa chỉ gửi hàng:\t',
                        style: TextStyle(
                          fontSize: width / 24.0,
                          fontFamily: 'Lato',
                          color: colorTitle,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '${widget.data['sender']['location']['address']}',
                        style: TextStyle(
                          fontSize: width / 26.0,
                          fontFamily: 'Lato',
                          color: colorTitle,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Số điện thoại người gửi:\n',
                        style: TextStyle(
                          fontSize: width / 24.0,
                          fontFamily: 'Lato',
                          color: colorTitle,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '${widget.data['sender']['phone']}',
                        style: TextStyle(
                          fontSize: width / 26.0,
                          fontFamily: 'Lato',
                          color: colorTitle,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              !widget.data['isMerchantSend']
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Divider(
                            color: colorDarkGrey,
                            thickness: .2,
                            height: .2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Tiêu đề:\t',
                                  style: TextStyle(
                                    fontSize: width / 24.0,
                                    fontFamily: 'Lato',
                                    color: colorPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.data['title']}',
                                  style: TextStyle(
                                    fontSize: width / 26.0,
                                    fontFamily: 'Lato',
                                    color: colorTitle,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mô tả:\t',
                                  style: TextStyle(
                                    fontSize: width / 24.0,
                                    fontFamily: 'Lato',
                                    color: colorTitle,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.data['description']}',
                                  style: TextStyle(
                                    fontSize: width / 26.0,
                                    fontFamily: 'Lato',
                                    color: colorTitle,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                      ],
                    )
                  : Container(),
              widget.data['historyStatus'].length > 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Divider(
                            color: colorDarkGrey,
                            thickness: .2,
                            height: .2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Trạng thái đơn hàng:\t',
                                  style: TextStyle(
                                    fontSize: width / 24.0,
                                    fontFamily: 'Lato',
                                    color: colorTitle,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.data['description']}',
                                  style: TextStyle(
                                    fontSize: width / 26.0,
                                    fontFamily: 'Lato',
                                    color: colorTitle,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        ListView.builder(
                          padding: EdgeInsets.only(left: 16.0, right: 8.0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.data['historyStatus'].length,
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data['historyStatus'][index]['title'],
                                  style: TextStyle(
                                    color: colorTitle,
                                    fontSize: width / 28.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  DateFormat('HH:mm, dd/MM/yyyy').format(
                                      DateTime.parse(
                                              widget.data['historyStatus']
                                                  [index]['createAt'])
                                          .toLocal()),
                                  style: TextStyle(
                                    color: colorPrimary,
                                    fontSize: width / 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
