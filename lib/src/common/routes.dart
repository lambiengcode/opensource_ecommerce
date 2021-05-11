class ApiGateway {
  // Authentication
  static const LOGIN_WITH_EMAIL = '/Auth/Login';
  static const REGISTER = '/Auth/Register';
  static const VERIFY = '/Auth/Verify';
  static const FORGOT_PASSWORD = '/Auth/ForgotPassword';
  static const CHANGE_PASSWORD = '/Auth/ChangePassword';

  // Device
  static const CREATE_DEVICE = '/Device/Create';
  static const DELETE_DEVICE = '/Device/Delete';

  // Transport
  static const REGISTER_TRANSPORT = '/Transport/Create';
}
