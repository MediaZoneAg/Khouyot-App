class ApiConstants{
  static const String baseUrl = 'https://scarf.jvinvestments.org/api/';
  static const String login = 'auth/login';
  static const String registeration = 'auth/register';
  static const String products = 'products';
  static const String categories = 'categories';
  static const String chCategories = 'products/categories/';
  static const String logout = 'client/logout';
  static const String profile = 'profile';
  static const String deleteAccount = 'custom/v1/delete-account';
  static const String forgotPassword = 'auth/reset-password';
  static const String resendCode = 'email-otp-authenticator/v1/resend';
  static const String otp = 'send-login-otp';
  static const String resetPassword = 'auth/reset-password';
  static const String changePassword = 'change-password';
  static const String addToWishList = 'favorites/';
  static const String getWishList = 'favorites/products';
  static const String removeFromWishList = 'favorites/';
  static const String addToCart = 'wc/v3/orders';
  static const String secretKey = 'ck_2f6500edc9e5f7a9ef8d4d17cb4a34d561d5d4b6';
  static const String consumerKey = 'cs_6b2f0a73a6a85c936bc7e35b86d6bdf83477cd3d';
  static const String search = 'wc/v3/products';
}