import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/home/controllers/product_global_controller.dart';
import 'package:van_transport/src/pages/home/widget/horizontal_store_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/services/string_service.dart';

class SearchProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final productController = Get.put(ProductGlobalController());
  final scrollController = ScrollController();
  int page = 1;
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
    productController.getProduct(page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: mC,
        child: GetBuilder<ProductGlobalController>(
          builder: (_) => Column(
            children: [
              SizedBox(height: height / 20.0),
              _buildTopbar(),
              SizedBox(height: 24.0),
              _buildListCategories(),
              SizedBox(height: 6.0),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollStartNotification) {
                    } else if (scrollNotification is ScrollUpdateNotification) {
                    } else if (scrollNotification is ScrollEndNotification) {
                      setState(() {
                        page++;
                      });
                      productController.getProduct(page);
                    }
                    return;
                  },
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Column(
                        children: [
                          SizedBox(height: 12.0),
                          _buildTitle('Popular Sale'),
                          SizedBox(height: 12.0),
                          _buildPopularStore(context, _.listProduct1),
                          SizedBox(height: 12.0),
                          _buildTitle('Recommanded for you'),
                          SizedBox(height: 12.0),
                          _buildPopularStore(context, _.listProduct2),
                          SizedBox(height: 12.0),
                          _buildTitle('Top Collection'),
                          SizedBox(height: 12.0),
                          _buildPopularStore(context, _.listProduct3),
                          SizedBox(height: 12.0),
                          _buildTitle('Upcomming'),
                          SizedBox(height: 12.0),
                          _buildPopularStore(context, _.listProduct4),
                          SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
        color: title == 'Back' ? colorBlack.withOpacity(.95) : mC,
      ),
      padding: EdgeInsets.all(width / 25.0),
      child: Icon(
        icon,
        color: title == 'Back' ? colorPrimaryTextOpacity : colorBlack,
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
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
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
      ),
    );
  }

  Widget _buildPopularStore(context, data) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width * .42,
      child: ListView.builder(
        controller: scrollController,
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
