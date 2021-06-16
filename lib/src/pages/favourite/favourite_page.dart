import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/models/action.dart';
import 'package:van_transport/src/pages/favourite/controllers/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/transport/widgets/vertical_transport_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/string_service.dart';

class FavouritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final favouriteController = Get.put(FavouriteController());
  String type = 'All';
  SlidableController slidableController = new SlidableController();

  @override
  void initState() {
    slidableController = SlidableController();
    favouriteController.getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mC,
        elevation: .0,
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          'favourite'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        color: mC,
        child: Column(
          children: [
            SizedBox(height: 2.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(
                horizontal: _size.width * .35,
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
                    size: _size.width / 16.0,
                    color: colorTitle,
                  ),
                  iconEnabledColor: Colors.grey.shade800,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: type,
                  items: actions.map((state) {
                    return DropdownMenuItem(
                        value: state.title,
                        child: Text(
                          state.title,
                          style: TextStyle(
                            fontSize: _size.width / 26.0,
                            color: colorTitle,
                            fontWeight: FontWeight.w500,
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
            SizedBox(height: 12.0),
            StreamBuilder(
              stream: favouriteController.getFavouritesStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                return Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowGlow();
                      return true;
                    },
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.265,
                            controller: slidableController,
                            child: GestureDetector(
                              onTap: () => Get.toNamed(Routes.DETAILSPRODUCT,
                                  arguments: snapshot.data[index]),
                              child: VerticalTransportCard(
                                image: null,
                                address: StringService()
                                    .formatPrice(snapshot.data[index]['price']),
                                title: snapshot.data[index]['name'],
                                urlToImage: snapshot.data[index]['image'],
                                desc: snapshot.data[index]['description'],
                              ),
                            ),
                            secondaryActions: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  slidableController.activeState.close();
                                  favouriteController.favourite(
                                    snapshot.data[index]['FK_product'],
                                    true,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      12.0, 20.0, 12.0, 24.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: mCD,
                                    boxShadow: [
                                      BoxShadow(
                                          color: mCL,
                                          offset: Offset(3, 3),
                                          blurRadius: 3,
                                          spreadRadius: -3),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Feather.trash_2,
                                    color: colorTitle,
                                    size: _size.width / 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
