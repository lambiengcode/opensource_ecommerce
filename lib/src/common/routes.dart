class ApiGateway {
  // Admin: 8
  static const REJECT_MERCHANT = '/Admin/RejectMerchant';
  static const CANCEL_MERCHANT = '/Admin/CancelMerchant';
  static const APPROVE_MERCHANT = '/Admin/ApproveMerchant';
  static const GET_MERCHANT_BY_STATUS = '/Admin/GetMerchantByStatus?status=';
  static const REJECT_TRANSPORT = '/Admin/RejectTransport';
  static const APPROVE_TRANSPORT = '/Admin/ApproveTransport';
  static const CANCEL_TRANSPORT = '/Admin/CancelTransport';
  static const GET_TRANSPORT_BY_STATUS = '/Admin/GetTransportByStatus?status=';

  // Authentication: 5
  static const LOGIN_WITH_EMAIL = '/Auth/Login';
  static const REGISTER = '/Auth/Register';
  static const REGISTER_STAFF = '/Auth/RegisterStaff';
  static const VERIFY = '/Auth/Verify';
  static const FORGOT_PASSWORD = '/Auth/ForgotPassword';
  static const CHANGE_PASSWORD = '/Auth/ChangePassword';

  // Coupon: 4
  static const CREATE_COUPON = '/Coupon/Create';
  static const UPDATE_COUPON = '/Coupon/Update';
  static const GET_COUPONS = '/Coupon/GetAll';
  static const DELETE_COUPON = '/Coupon/Delete?id=';

  // Category: 4
  static const CREATE_CATEGORY = '/Category/Create';
  static const UPDATE_CATEGORY = '/Category/Update';
  static const GET_CATEGORIES = '/Category/GetAll';
  static const DELETE_CATEGORY = '/Category/Delete?id=';

  // User: 8
  static const GET_PROFILE = '/User/GetInfo';
  static const UPDATE_PROFILE = '/User/Update';
  static const BUY_POINT = '/User/BuyPoint';
  static const ADD_ADDRESS = '/User/AddAddress';
  static const UPDATE_ADDRESS = '/User/UpdateAddress';
  static const DELETE_ADDRESS = '/User/DeleteAddress?id=';
  static const FAVORITE = '/User/Favorite';
  static const GET_FAVORITE = '/User/GetFavorites';
  static const ADD_PRODUCT_TO_CART_CLIENT = '/User/Client/AddProductToCart';
  static const ADD_PRODUCT_TO_CART_MERCHANT = '/User/Merchant/AddProductToCart';
  static const GET_CART_CLIENT = '/User/Client/GetMyCart';
  static const GET_CART_MERCHANT = '/User/Merchant/GetMyCart';
  static const GET_TRANSPORT_DELIVERY =
      '/Admin/GetTransportByAddress?receiverIdAddress=';
  static const GET_TRANSPORT_DELIVERY_CLIENT =
      '/Admin/GetTransportByAddressClient?senderIdAddress=';
  static const PAYMENT_CART_MERCHANT = '/User/Merchant/PaymentCart';
  static const PAYMENT_CART_CLIENT = '/User/Client/PaymentCart';
  static const DELETE_CART_MERCHANT = '/User/Merchant/DeleteProductFromCart';
  static const DELETE_CART_CLIENT = '/User/Client/DeleteProductFromCart';
  static const UPDATE_CART_CLIENT = '/User/Client/UpdateProductFromCart';
  static const UPDATE_CART_MERCHANT = '/User/Merchant/UpdateProductFromCart';
  static const GET_ORDER_BY_STATUS = '/User/OrderByStatus?status=';
  static const FAVOURITE_PRODUCT = '/User/OrderByStatus?status=';

  // Device: 2
  static const CREATE_DEVICE = '/Device/Create';
  static const DELETE_DEVICE = '/Device/Delete?deviceUUid=';

  // Transport: 4
  static const REGISTER_TRANSPORT = '/Transport/Create';
  static const ASSIGN_TRANSPORT = '/Transport/AssignStaff';
  static const UPDATE_TRANSPORT = '/Transport/Update';
  static const GET_TRANSPORT = '/Transport/GetInfo';
  static const GET_ASSIGN_STAFF = '/Transport/GetAssignStaff';
  static const UPDATE_PRICE_TYPE = '/Transport/UpdatePriceType';

  // Subtransport: 4
  static const REGISTER_TRANSPORTSUB = '/TransportSub/Create';
  static const ASSIGN_TRANSPORTSUB = '/TransportSub/ChangeStatus';
  static const UPDATE_TRANSPORTSUB = '/TransportSub/Update';
  static const GET_TRANSPORTSUB = '/TransportSub/GetInfo';
  static const DELETE_TRANSPORTSUB = '/TransportSub/ChangeStatus';
  static const GET_ALL_SUB_BY_STATUS = '/Transport/GetAllTransportSub?status=';
  static const GET_ORDER_BY_STATUS_TRANSPORT =
      '/TransportSub/OrderByStatus?status=';

  static const CREATE_PACKAGE = '/Package/Create';

  // Merchant: 3
  static const GET_MERCHANT = '/Merchant/GetInfo';
  static const CREATE_MERCHANT = '/Merchant/Create';
  static const UPDATE_MERCHANT = '/Merchant/Update';
  static const GET_MERCHANT_BY_ID = '/Merchant/GetById?id=';
  static const GET_ORDER_BY_STATUS_MERCHANT = '/Merchant/OrderByStatus?status=';

  // Group Product: 4
  static const CREATE_GROUP_PRODUCT = '/GroupProduct/Create';
  static const UPDATE_GROUP_PRODUCT = '/GroupProduct/Update';
  static const GET_GROUP_PRODUCT = '/GroupProduct/GetAll?idMerchant=';
  static const DELETE_GROUP_PRODUCT = '/GroupProduct/Delete?id=';

  // Product: 5
  static const CREATE_PRODUCT = '/Product/Create';
  static const UPDATE_PRODUCT = '/Product/Update';
  static const DELETE_PRODUCT = '/Product/Delete?id=';
  static const GET_PRODUCT_BY_MERCHANT = '/Product/GetProductByMerchant?id=';
  static const GET_PRODUCT_BY_GROUP = '/Product/GetProductByGroup?id=';
  static const GET_ALL_PRODUCT = '/Product/GetAll?page=';
}
