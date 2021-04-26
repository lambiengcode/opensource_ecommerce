import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/home/widget/horizontal_store_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class SearchProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  List<String> categories = [
    'Popular',
    'Electric',
    'Fashion',
    'Food',
    'Phone',
    'Shoe',
  ];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: mC,
        child: Column(
          children: [
            SizedBox(height: height / 20.0),
            _buildTopbar(),
            SizedBox(height: 24.0),
            _buildListCategories(),
            SizedBox(height: 6.0),
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Column(
                    children: [
                      SizedBox(height: 12.0),
                      _buildTitle('Popular Sale'),
                      SizedBox(height: 12.0),
                      _buildPopularStore(context),
                      SizedBox(height: 12.0),
                      _buildTitle('Recommanded for you'),
                      SizedBox(height: 12.0),
                      _buildPopularStore(context),
                      SizedBox(height: 12.0),
                      _buildTitle('Top Collection'),
                      SizedBox(height: 12.0),
                      _buildPopularStore(context),
                      SizedBox(height: 12.0),
                      _buildTitle('Upcomming'),
                      SizedBox(height: 12.0),
                      _buildPopularStore(context),
                      SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopbar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionTopbar('Back', Feather.arrow_left),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildActionTopbar('Search', Feather.search),
              SizedBox(width: 16.0),
              _buildActionTopbar('Cart', Feather.shopping_cart),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionTopbar(title, icon) {
    return NeumorphicButton(
      onPressed: () => title == 'Back'
          ? Get.back()
          : title == 'Cart'
              ? Get.toNamed(Routes.CART)
              : null,
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 6.0,
        intensity: .75,
        color: title == 'Back' ? colorBlack : mC,
      ),
      padding: EdgeInsets.all(width / 25.0),
      child: Icon(
        icon,
        color: title == 'Back' ? mC : colorBlack,
        size: width / 18.0,
      ),
      duration: Duration(milliseconds: 200),
    );
  }

  Widget _buildListCategories() {
    return Container(
      height: width * .135,
      width: width,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return NeumorphicButton(
            onPressed: () => null,
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(8.0),
              ),
              depth: 4.0,
              intensity: .65,
              color: mC,
            ),
            margin: EdgeInsets.only(right: 12.0, bottom: width / 32.0),
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categories[index],
                  style: TextStyle(
                    color: colorDarkGrey,
                    fontFamily: 'Lato',
                    fontSize: width / 30.0,
                  ),
                ),
              ],
            ),
            duration: Duration(milliseconds: 200),
          );
        },
      ),
    );
  }

  Widget _buildTitle(title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorTitle,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600,
            fontSize: width / 22.5,
          ),
        ),
        Text(
          'viewall'.trArgs(),
          style: TextStyle(
            color: colorPrimary,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            fontSize: width / 26.0,
          ),
        ),
      ],
    );
  }

  Widget _buildPopularStore(context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width * .42,
      child: ListView.builder(
        padding: EdgeInsets.only(right: 12.0),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.DETAILSPRODUCT, arguments: {
              'name': 'CARAMEL PHIN FREEZE',
              'image':
                  'https://images.unsplash.com/photo-1494314671902-399b18174975?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8NDR8fGNvZmZlZXxlbnwwfHwwfA%3D%3D&auto=format&fit=crop&w=500&q=60',
              'owner': 'lambiengcode\'store',
              'description':
                  'Nếu bạn là người yêu thích những gì mới mẻ và sành điệu để khơi nguồn cảm hứng. Hãy thưởng thức ngay các món nước đá xay độc đáo mang hương vị tự nhiên tại Highlands Coffee để đánh thức mọi giác quan của bạn, giúp bạn luôn căng tràn sức sống.',
              'price': '49000',
            }),
            child: HorizontalStoreCard(),
          );
        },
      ),
    );
  }
}
