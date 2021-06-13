import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/home/controllers/carousel_controller.dart';
import 'package:van_transport/src/widgets/error_loading_image.dart';
import 'package:van_transport/src/widgets/place_holder_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CarouselImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List imgList = [
    'https://salt.tikicdn.com/cache/w824/ts/banner/61/45/25/6c3240218851d381e6e02f2e94e5edfa.png.jpg',
    'https://salt.tikicdn.com/cache/w824/ts/banner/ae/bc/81/9af01aec2fdde78a41d33874cd57784b.jpg',
    'https://salt.tikicdn.com/cache/w824/ts/banner/5a/dc/c6/24c5c8b774cbd907c52497c467581166.png.jpg',
    'https://salt.tikicdn.com/cache/w824/ts/banner/1f/00/a2/312c8be9356a2e1be67d50376946ddce.png.jpg',
    'https://salt.tikicdn.com/cache/w824/ts/banner/53/fe/02/369e48600953dea7d8a1d5df5a71ac98.png.jpg',
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
                    borderRadius: BorderRadius.circular(12.0),
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
              padding: EdgeInsets.only(left: 16.0),
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
