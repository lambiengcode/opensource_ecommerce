import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_ec/src/common/style.dart';
import 'package:ecommerce_ec/src/pages/home/controllers/carousel_controller.dart';
import 'package:ecommerce_ec/src/widgets/error_loading_image.dart';
import 'package:ecommerce_ec/src/widgets/place_holder_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CarouselImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List imgList = [
    'https://www.highlandscoffee.com.vn/vnt_upload/weblink/HCO-7605-FESTIVE-2020-WEB-FB-2000X639_1.png',
    'https://www.highlandscoffee.com.vn/vnt_upload/news/12_2019/HCO-7605-FESTIVE-2020-INSIDE-BOOKLET-FA-2.jpg',
    'https://www.highlandscoffee.com.vn/vnt_upload/weblink/HCO-7548-PHIN-SUA-DA-2019-TALENT-WEB_1.jpg',
    'https://www.highlandscoffee.com.vn/vnt_upload/weblink/web_1.png',
    'https://www.highlandscoffee.com.vn/vnt_upload/news/12_2019/HCO-7605-FESTIVE-2020-INSIDE-BOOKLET-FA-3.jpg'
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return GetBuilder<CarouselBannerController>(
      init: CarouselBannerController(),
      builder: (_) => Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: _size.height * .16,
              aspectRatio: 1 / 1,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) =>
                  Get.find<CarouselBannerController>().updateIndex(index),
            ),
            items: imgList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: CachedNetworkImage(
                        width: _size.width,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => PlaceHolderImage(),
                        errorWidget: (context, url, error) =>
                            ErrorLoadingImage(),
                        imageUrl: imgList[_.index]),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 10.0,
            child: Container(
              width: _size.width * .9,
              padding: EdgeInsets.only(left: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: map<Widget>(imgList, (index, url) {
                  return Container(
                    width: _.index == index ? 6.0 : 2.5,
                    height: _.index == index ? 6.0 : 2.5,
                    margin: EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      color:
                          _.index == index ? mCL : Colors.white.withOpacity(.9),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
