import 'package:ecommerce_ec/src/common/style.dart';
import 'package:ecommerce_ec/src/pages/profile/widgets/friend_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class AddFriendPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  ScrollController scrollCosmetic = new ScrollController();
  String _search = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: mC,
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 32.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: NMButton(
                    down: false,
                    icon: Icons.arrow_back,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 55.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        color: mC,
                        boxShadow: [
                          BoxShadow(
                            color: mCD,
                            offset: Offset(10, 10),
                            blurRadius: 10,
                          ),
                          BoxShadow(
                            color: mCL,
                            offset: Offset(-10, -10),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: TextFormField(
                        cursorColor: colorTitle,
                        cursorRadius: Radius.circular(8.0),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: _size.width / 26.0,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (val) {
                          setState(() {
                            _search = val.trim();
                          });
                        },
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 15.0),
                          prefixIcon: Icon(
                            Feather.search,
                            color: Colors.grey.shade600,
                            size: _size.width / 26.0,
                          ),
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: fCL,
                            fontSize: _size.width / 26.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                NMButton(
                  down: false,
                  icon: Icons.filter_alt,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: GetBuilder(
                  builder: (controller) => ListView.builder(
                    controller: scrollCosmetic,
                    padding: EdgeInsets.only(top: .0),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return FriendCard(
                        addFriend: true,
                        index: index,
                        isLast: index == 19,
                        image:
                            'https://avatars.githubusercontent.com/u/60530946?v=4',
                        fullName: 'lambiengcode',
                        address: 'Ho Chi Minh, Viet Nam',
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
