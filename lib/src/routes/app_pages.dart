import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/middleware/merchant_middleware.dart';
import 'package:van_transport/src/pages/admin/admin_page.dart';
import 'package:van_transport/src/pages/admin/pages/manage_coupon_page.dart';
import 'package:van_transport/src/pages/admin/pages/manage_merchant_page.dart';
import 'package:van_transport/src/pages/admin/pages/manage_transport_page.dart';
import 'package:van_transport/src/pages/authentication/pages/forgot_password_page.dart';
import 'package:van_transport/src/pages/authentication/pages/signup_staff_page.dart';
import 'package:van_transport/src/pages/authentication/pages/verify_page.dart';
import 'package:van_transport/src/pages/home/pages/details_product_page.dart';
import 'package:van_transport/src/pages/home/pages/search_product_page.dart';
import 'package:van_transport/src/pages/home/pages/store_page.dart';
import 'package:van_transport/src/pages/merchant/merchant_page.dart';
import 'package:van_transport/src/pages/merchant/pages/create_group_page.dart';
import 'package:van_transport/src/pages/merchant/pages/create_product_page.dart';
import 'package:van_transport/src/pages/merchant/pages/details_product_group_page.dart';
import 'package:van_transport/src/pages/merchant/pages/edit_group_page.dart';
import 'package:van_transport/src/pages/merchant/pages/edit_merchant_page.dart';
import 'package:van_transport/src/pages/merchant/pages/edit_product_page.dart';
import 'package:van_transport/src/pages/merchant/pages/register_merchant_page.dart';
import 'package:van_transport/src/pages/order/pages/add_product_page.dart';
import 'package:van_transport/src/pages/order/pages/cart_page.dart';
import 'package:van_transport/src/pages/order/pages/check_out_order_page.dart';
import 'package:van_transport/src/pages/order/pages/check_out_page.dart';
import 'package:van_transport/src/pages/order/pages/create_order_page.dart';
import 'package:van_transport/src/pages/order/pages/details_orders_page.dart';
import 'package:van_transport/src/pages/order/pages/pick_address_page.dart';
import 'package:van_transport/src/pages/payment/web_view_payment.dart';
import 'package:van_transport/src/pages/profile/pages/add_friend_page.dart';
import 'package:van_transport/src/pages/profile/pages/address_page.dart';
import 'package:van_transport/src/pages/profile/pages/change_password_page.dart';
import 'package:van_transport/src/pages/profile/pages/create_address_page.dart';
import 'package:van_transport/src/pages/profile/pages/edit_address_page.dart';
import 'package:van_transport/src/pages/profile/pages/edit_profile_page.dart';
import 'package:van_transport/src/pages/profile/pages/friends_page.dart';
import 'package:van_transport/src/pages/profile/pages/my_point_page.dart';
import 'package:van_transport/src/pages/profile/pages/search_friend_page.dart';
import 'package:van_transport/src/pages/profile/pages/settings_page.dart';
import 'package:van_transport/src/pages/staff/staff_page.dart';
import 'package:van_transport/src/pages/sub_city/sub_city_page.dart';
import 'package:van_transport/src/pages/sub_transport/sub_transport_page.dart';
import 'package:van_transport/src/pages/transport/pages/edit_transport_page.dart';
import 'package:van_transport/src/pages/transport/pages/register_transport_page.dart';
import 'package:van_transport/src/pages/transport/transport_page.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: Routes.ROOT,
      page: () => App(),
      children: [],
    ),

    // Auth
    GetPage(
      name: Routes.VERIFY,
      page: () => VerifyPage(email: Get.arguments),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.FORGOTPASSWORD,
      page: () => ForgotPasswordPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
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
    GetPage(
      name: Routes.DETAILSORDERS,
      page: () => DetailsOrdersPage(),
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
      page: () => AddressPage(mode: Get.arguments),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.CREATEADDRESS,
      page: () => CreateAddressPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.EDITADDRESS,
      page: () => EditAddressPage(
        addressInfo: Get.arguments,
      ),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.PAYMENTWEBVIEW,
      page: () => WebViewPage(
        urlToWeb: Get.arguments,
      ),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [],
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      children: [
        GetPage(
          name: Routes.CHANGEPASSWORD,
          page: () => ChangePasswordPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
      ],
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
          name: Routes.MIDDLEWAREMERCHANT,
          page: () => MerchantMiddleware(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.REGISTERMERCHANT,
          page: () => RegisterMerchantPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.EDITMERCHANT,
          page: () => EditMerchantPage(
            merchantInfo: Get.arguments,
          ),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.CREATEGROUP,
          page: () => CreateGroupPage(
            idMerchant: Get.arguments,
          ),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.EDITGROUP,
          page: () => EditGroupPage(
            groupProductInfo: Get.arguments,
          ),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.DETAILSGROUP,
          page: () => DetailsProductGroupPage(
            title: Get.arguments['title'],
            idMerchant: Get.arguments['idMerchant'],
            idGroup: Get.arguments['idGroup'],
          ),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.CREATEPRODUCT,
          page: () => CreateProductPage(
            idGroup: Get.arguments['idGroup'],
            idMerchant: Get.arguments['idMerchant'],
          ),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
          children: [],
        ),
        GetPage(
          name: Routes.EDITPRODUCT,
          page: () => EditProductPage(
            infoProduct: Get.arguments,
          ),
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
      children: [
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
      ],
    ),

    GetPage(
      name: Routes.STAFFDELIVERY,
      page: () => StaffPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(microseconds: 200),
      children: [],
    ),

    GetPage(
      name: Routes.SUBTRANSPORT,
      page: () => SubTransportPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(microseconds: 200),
      children: [],
    ),

    GetPage(
      name: Routes.SUBCITY,
      page: () => SubCityPage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(microseconds: 200),
      children: [
        GetPage(
          name: Routes.REGISTERSTAFF,
          page: () => SignupStaffPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(microseconds: 200),
          children: [],
        ),
      ],
    ),
  ];
}
