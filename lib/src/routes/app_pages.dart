import 'package:ecommerce_ec/src/app.dart';
import 'package:ecommerce_ec/src/pages/admin/admin_page.dart';
import 'package:ecommerce_ec/src/pages/admin/pages/manage_coupon_page.dart';
import 'package:ecommerce_ec/src/pages/admin/pages/manage_merchant_page.dart';
import 'package:ecommerce_ec/src/pages/admin/pages/manage_transport_page.dart';
import 'package:ecommerce_ec/src/pages/home/pages/details_product_page.dart';
import 'package:ecommerce_ec/src/pages/home/pages/search_product_page.dart';
import 'package:ecommerce_ec/src/pages/home/pages/store_page.dart';
import 'package:ecommerce_ec/src/pages/merchant/merchant_page.dart';
import 'package:ecommerce_ec/src/pages/merchant/pages/edit_merchant_page.dart';
import 'package:ecommerce_ec/src/pages/merchant/pages/register_merchant_page.dart';
import 'package:ecommerce_ec/src/pages/order/pages/add_product_page.dart';
import 'package:ecommerce_ec/src/pages/order/pages/cart_page.dart';
import 'package:ecommerce_ec/src/pages/order/pages/check_out_order_page.dart';
import 'package:ecommerce_ec/src/pages/order/pages/check_out_page.dart';
import 'package:ecommerce_ec/src/pages/order/pages/create_order_page.dart';
import 'package:ecommerce_ec/src/pages/order/pages/pick_address_page.dart';
import 'package:ecommerce_ec/src/pages/profile/pages/add_friend_page.dart';
import 'package:ecommerce_ec/src/pages/profile/pages/address_page.dart';
import 'package:ecommerce_ec/src/pages/profile/pages/edit_profile_page.dart';
import 'package:ecommerce_ec/src/pages/profile/pages/friends_page.dart';
import 'package:ecommerce_ec/src/pages/profile/pages/my_point_page.dart';
import 'package:ecommerce_ec/src/pages/profile/pages/search_friend_page.dart';
import 'package:ecommerce_ec/src/pages/profile/pages/settings_page.dart';
import 'package:ecommerce_ec/src/pages/transport/pages/edit_transport_page.dart';
import 'package:ecommerce_ec/src/pages/transport/pages/register_transport_page.dart';
import 'package:ecommerce_ec/src/pages/transport/transport_page.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: Routes.ROOT,
      page: () => App(),
      children: [],
    ),

    // Home
    GetPage(
      name: Routes.SEARCHPRODUCT,
      page: () => SearchProductPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),

    GetPage(
      name: Routes.DETAILSPRODUCT,
      page: () => DetailsProductPage(
        image: Get.arguments['image'],
        name: Get.arguments['name'],
        description: Get.arguments['description'],
        price: Get.arguments['price'],
        owner: Get.arguments['owner'],
      ),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),

    GetPage(
      name: Routes.STORE,
      page: () => StorePage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),

    // Order
    GetPage(
      name: Routes.CART,
      page: () => CartPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.CHECKOUT,
      page: () => CheckOutPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.CREATEORDER,
      page: () => CreateOrderPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.PICKADDRESS,
      page: () => PickAddressPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.CHECKOUTORDER,
      page: () => CheckOutOrderPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.ADDPRODUCT,
      page: () => AddProductPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),

    // Profile
    GetPage(
      name: Routes.POINT,
      page: () => MyPointPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.MYFRIENDS,
      page: () => FriendsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [
        GetPage(
          name: Routes.SEARCHFRIEND,
          page: () => SearchFriendPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.ADDFRIEND,
          page: () => AddFriendPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
      ],
    ),
    GetPage(
      name: Routes.EDITPROFILE,
      page: () => MyProfilePage(
        urlToImage: Get.arguments['image'],
        fullName: Get.arguments['fullName'],
        phoneNumber: Get.arguments['phone'],
        email: Get.arguments['email'],
        createdAt: DateTime.parse(Get.arguments['createdAt']),
        point: Get.arguments['point'].toString(),
        role: Get.arguments['role'],
      ),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.ADDRESS,
      page: () => AddressPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),

    // Admin
    GetPage(
      name: Routes.ADMIN,
      page: () => AdminPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [
        GetPage(
          name: Routes.MANAGEMERCHANT,
          page: () => ManageMerchantPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.MANAGETRANSPORT,
          page: () => ManageTransportPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.MANAGEPROMO,
          page: () => ManageCouponPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
      ],
    ),

    // Merchant
    GetPage(
      name: Routes.MERCHANT,
      page: () => MerchantPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [
        GetPage(
          name: Routes.REGISTERMERCHANT,
          page: () => RegisterMerchantPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.EDITMERCHANT,
          page: () => EditMerchantPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
      ],
    ),

    // Delivery
    GetPage(
      name: Routes.DELIVERY,
      page: () => TransportPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.REGISTERDELIVERY,
      page: () => RegisterTransportPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.EDITDELIVERY,
      page: () => EditTransportPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
  ];
}
