import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/profile/widgets/friend_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class FriendsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mC,
        elevation: .0,
        centerTitle: true,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: width / 15.0,
          ),
        ),
        title: Text(
          'myFriends'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Get.toNamed(Routes.MYFRIENDS + Routes.SEARCHFRIEND),
            icon: Icon(
              Feather.search,
              color: colorTitle,
              size: width / 16.0,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.MYFRIENDS + Routes.ADDFRIEND),
        child: Icon(
          Feather.plus,
          color: mCL,
          size: width / 16.0,
        ),
        backgroundColor: colorPrimary,
      ),
      body: Container(
        color: mC,
        child: Column(
          children: [
            SizedBox(height: 2.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(
                horizontal: width * .35,
              ),
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
            SizedBox(height: 4.0),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return FriendCard(
                      addFriend: false,
                      index: index,
                      isLast: index == 9,
                      image:
                          'https://avatars.githubusercontent.com/u/60530946?v=4',
                      fullName: 'lambiengcode',
                      address: 'Ho Chi Minh, Viet Nam',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
