import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/models/action.dart';
import 'package:van_transport/src/pages/home/controllers/action_controller.dart';
import 'package:van_transport/src/pages/home/controllers/carousel_controller.dart';
import 'package:van_transport/src/pages/home/controllers/product_global_controller.dart';
import 'package:van_transport/src/pages/home/widget/action_button.dart';
import 'package:van_transport/src/pages/home/widget/carousel_banner.dart';
import 'package:van_transport/src/pages/home/widget/horizontal_store_card.dart';
import 'package:van_transport/src/pages/transport/widgets/vertical_transport_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:van_transport/src/services/string_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productController = Get.put(ProductGlobalController());
  final scrollController = ScrollController();
  final scrollHorizontalController = ScrollController();
  LocationData currentLocation;
  Future<dynamic> _myLocation;

  getUserLocation() async {
    //call this async method from whereever you need

    LocationData myLocation;
    String error;
    Location location = new Location();
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
    currentLocation = myLocation;
    final coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    String result = '${first.addressLine}';
    print(
        ' ${first.locality},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    result = result.replaceAll(first.adminArea, '');
    result = result.replaceAll(first.countryName, '');
    return result;
  }

  @override
  void initState() {
    super.initState();
    productController.getProduct();
    _myLocation = getUserLocation();
    Get.put(ActionController(), permanent: true);
    Get.put(CarouselBannerController(index: 0), permanent: true);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          productController.getProduct();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: _size.height / 22.0),
            _buildTopBar(context),
            SizedBox(height: 12.0),
            Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                  } else if (scrollNotification is ScrollUpdateNotification) {
                  } else if (scrollNotification is ScrollEndNotification) {
                    productController.getProduct();
                  }
                  return;
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: GetBuilder<ProductGlobalController>(
                    builder: (_) => Column(
                      children: [
                        _buildCarouselBanner(context),
                        SizedBox(height: 12.0),
                        _buildTitle(context, 'category'.trArgs()),
                        SizedBox(height: 5.0),
                        _buildHorizontalAction(context),
                        SizedBox(height: 10.0),
                        _buildTitle(context, 'mostPopular'.trArgs()),
                        SizedBox(height: 10.0),
                        _buildPopularStore(context, _.listProduct1),
                        SizedBox(height: 10.0),
                        _buildTitle(context, 'onSale'.trArgs()),
                        SizedBox(height: 10.0),
                        _buildPopularStore(context, _.listProduct2),
                        SizedBox(height: 10.0),
                        _buildTitle(context, 'nearBy'.trArgs()),
                        SizedBox(height: 10.0),
                        _buildPopularStore(context, _.listProduct3),
                        SizedBox(height: 10.0),
                        _buildTitle(context, 'product'.trArgs()),
                        SizedBox(height: 10.0),
                        ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.only(top: .0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _.listProduct4.length < 75
                              ? _.listProduct4.length
                              : 75,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Get.toNamed(Routes.DETAILSPRODUCT,
                                  arguments: _.listProduct4[index]),
                              child: VerticalTransportCard(
                                image: null,
                                address: StringService().formatPrice(
                                    _.listProduct4[index]['price']),
                                title: _.listProduct4[index]['name'],
                                urlToImage: _.listProduct4[index]['image'],
                                desc: _.listProduct4[index]['description'],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(context) {
    final _size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(Routes.ADDRESS, arguments: {
            'pickMode': '',
            'isFrom': false,
          }),
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 12.5),
                      Icon(
                        Feather.target,
                        color: colorPrimary,
                        size: _size.width / 16.0,
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'deliver'.trArgs(),
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: _size.width / 22.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          FutureBuilder(
                            future: _myLocation,
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Text(
                                    'Thành Phố Hồ Chí Minh, Việt Nam',
                                    style: TextStyle(
                                      color: colorTitle,
                                      fontSize: _size.width / 26.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                default:
                                  if (snapshot.hasError) {
                                    return Text(
                                      'Thành Phố Hồ Chí Minh, Việt Nam',
                                      style: TextStyle(
                                        color: colorTitle,
                                        fontSize: _size.width / 26.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  }

                                  return Text(
                                    snapshot.data.toString().length > 40
                                        ? snapshot.data
                                                .toString()
                                                .substring(0, 38) +
                                            '..'
                                        : snapshot.data.toString(),
                                    style: TextStyle(
                                      color: colorTitle,
                                      fontSize: _size.width / 26.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Get.toNamed('/address'),
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: _size.width / 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.SEARCHPRODUCT),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            height: 48.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
              color: mC,
              boxShadow: [
                BoxShadow(
                  color: mCD,
                  offset: Offset(4, 4),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: mCL,
                  offset: Offset(-4, -4),
                  blurRadius: 4,
                ),
              ],
            ),
            padding: EdgeInsets.only(
              left: 16.0,
              right: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Feather.search,
                      size: _size.width / 21.5,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'searchHide'.trArgs(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: _size.width / 26.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
                Icon(
                  Feather.list,
                  size: _size.width / 20.0,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselBanner(context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * .13,
      margin: EdgeInsets.symmetric(
        horizontal: 14.0,
      ),
      child: CarouselImage(),
    );
  }

  Widget _buildHorizontalAction(context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(2.0, .0, 2.0, 4.0),
      height: _size.width * .25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        itemBuilder: (context, index) {
          return ActionButton(
            index: index,
            title: actions[index].title,
            icon: actions[index].icon,
          );
        },
      ),
    );
  }

  Widget _buildTitle(context, title) {
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 14.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colorTitle,
              fontSize: _size.width / 22.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.SEARCHPRODUCT),
            child: Text(
              'viewall'.trArgs(),
              style: TextStyle(
                color: colorPrimary,
                fontSize: _size.width / 28.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularStore(context, data) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width * .42,
      child: ListView.builder(
        controller: scrollHorizontalController,
        padding: EdgeInsets.only(left: 6.0, right: 12.0),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                Get.toNamed(Routes.DETAILSPRODUCT, arguments: data[index]),
            child: HorizontalStoreCard(
              address: StringService().formatPrice(data[index]['price']),
              title: data[index]['name'],
              urlToImage: data[index]['image'],
              desc: data[index]['description'],
            ),
          );
        },
      ),
    );
  }
}
