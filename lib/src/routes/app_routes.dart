part of 'app_pages.dart';

abstract class Routes {
  // Root
  static const ROOT = '/root';
  // Home
  static const HOME = '/home';
  static const SEARCHPRODUCT = '/searchProduct';
  static const DETAILSPRODUCT = '/detailsProduct';
  static const STORE = '/store';

  // Order
  static const CART = '/cart';
  static const CHECKOUT = '/checkOut';
  static const CREATEORDER = '/createOrder';
  static const PICKADDRESS = '/pickAddress';
  static const CHECKOUTORDER = '/checkOutOrder';
  static const ADDPRODUCT = '/addProduct';

  // Profile
  static const EDITPROFILE = '/editProfile';
  static const POINT = '/myPoint';
  static const MYFRIENDS = '/myFriend';
  static const SEARCHFRIEND = '/searchFriend';
  static const ADDFRIEND = '/addFriend';
  static const ADDRESS = '/address';
  static const SETTINGS = '/settings';

  // Admin
  static const ADMIN = '/admin';
  static const MANAGEMERCHANT = '/manageMerchant';
  static const MANAGETRANSPORT = '/manageTransport';
  static const MANAGEPROMO = '/managePromo';

  // Merchant
  static const MERCHANT = '/merchant';
  static const REGISTERMERCHANT = '/registerMerchant';
  static const EDITMERCHANT = '/editMerchant';
  static const CREATEGROUP = '/createGroup';
  static const DETAILSGROUP = 'detailsGroup';
  static const CREATEPRODUCT = '/createProduct';
  static const EDITPRODUCT = '/editProduct';

  // Delivery
  static const DELIVERY = '/delivery';
  static const REGISTERDELIVERY = '/registerDelivery';
  static const EDITDELIVERY = '/editDelivery';

  // Staff Delivery
  static const STAFFDELIVERY = '/subDelivery';

  // SubCity
  static const SUBCITY = '/subCity';
  static const REGISTERSTAFF = '/registerStaff';

  // SubTransport
  static const SUBTRANSPORT = '/subTransport';
}
