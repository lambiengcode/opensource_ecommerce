class ApiGateway {
  // Authentication
  static const LOGIN_WITH_EMAIL = '/Auth/Login';
  static const REGISTER = '/Auth/Register';
  static const VERIFY = '/Auth/Verify';
  static const FORGOT_PASSWORD = '/Auth/ForgotPassword';
  static const CHANGE_PASSWORD = '/Auth/ChangePassword';

  // User
  static const GET_PROFILE = '/User/GetInfo';
  static const UPDATE_PROFILE = '/User/Update';

  // Device
  static const CREATE_DEVICE = '/Device/Create';
  static const DELETE_DEVICE = '/Device/Delete';

  // Transport
  static const REGISTER_TRANSPORT = '/Transport/Create';

  // Merchant
  static const GET_MERCHANT = '/Merchant/GetInfo';
  static const CREATE_MERCHANT = '/Merchant/Create';
  static const UPDATE_MERCHANT = '/Merchant/Update';
}
