import 'package:flutter/material.dart';
import 'package:van_transport/src/common/style.dart';

class BottomSettingsProduct extends StatefulWidget {
  final List<String> values;
  BottomSettingsProduct({this.values});
  @override
  State<StatefulWidget> createState() => _BottomSettingsProductState();
}

class _BottomSettingsProductState extends State<BottomSettingsProduct> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            20.0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.5),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: _size.width * .35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: mCD,
                boxShadow: [
                  BoxShadow(
                    color: mCD,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0,
                  ),
                  BoxShadow(
                    color: mCL,
                    offset: Offset(-1.0, -1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            _buildAction(context, widget.values[0]),
            Divider(
              color: mCH,
              thickness: .2,
              height: .2,
              indent: 12.0,
              endIndent: 12.0,
            ),
            _buildAction(context, widget.values[1]),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(context, title) {
    final _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: _size.width,
        color: mC,
        padding: EdgeInsets.fromLTRB(24.0, 15.0, 20.0, 15.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: _size.width / 24.0,
            color: colorDarkGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
