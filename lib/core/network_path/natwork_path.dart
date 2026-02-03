class Urls {
  static const String _baseUrl =
      'http://10.0.20.177:12030/api/v1'; // Re-check this IP and port

  static const String baseUrl =
      'http://10.0.20.177:12030/api/v1'; // Re-check this IP and port

  // Auth URLs
  static const String login = '$baseUrl/auth/login';
  static const String authSignUp = '$baseUrl/auth/register';
  static const String authForgetSendOtp = '$baseUrl/auth/forgot-password';
  static const String authFVerifyOtp = '$baseUrl/auth/verify-otp';
  static const String authResendOtp = '$baseUrl/auth/resend-otp';
  static const String authForgetResetPassword = '$baseUrl/auth/reset-password';
  static const String authVerifyOtp = '$baseUrl/auth/verify-otp';

  // User URLs

  static const String getUserDataUrl = '$_baseUrl/users/profile';
  static const String editUserDataUrl = '$_baseUrl/users/update-profile';
  static const String addressCreateUrl = '$_baseUrl/address/create';
  static const String getAllAddressCreateUrl = '$_baseUrl/address/my-address';
  static String getSingleAddressCreateUrl(String id) =>
      '$_baseUrl/address/my-address/$id';
  static String deleteSingleAddressCreateUrl(String id) =>
      '$_baseUrl/address/delete/$id';
  static String updateSingleAddressCreateUrl(String id) =>
      '$_baseUrl/address/update/$id';
  static const String logout = '$_baseUrl/profile/logout';
  static const String deleteUserDataUrl = '$_baseUrl/auth/delete-user';
  static const String userChangePassword = '$_baseUrl/change-password';

  // Product URLs

  static const String allProduct = '$_baseUrl/products/all';
  static String allProductSearch(String? query) =>
      '$_baseUrl/products/all?searchTerm=$query';
  static String singleProductId(String id) => '$_baseUrl/products/single/$id';
  static String deleteProductId(String id) => '$_baseUrl/products/delete/$id';

  //Add to Cart
  static const String createAddToCart = '$_baseUrl/add-to-cart/create';
  static const String myCartsAddToCart = '$_baseUrl/add-to-cart/my-carts';
  static String singleAddToCart(String id) =>
      '$_baseUrl/add-to-cart/single/$id';
  static String addToCartUpdateId(String? id) =>
      '$_baseUrl/add-to-cart/update/$id';
  static String addToCartDeleteId(String? id) =>
      '$_baseUrl/add-to-cart/delete/$id';

  //Order
  static const String createOrder = '$_baseUrl/orders/create';
  static String singleOrderId(String id) => '$_baseUrl/orders/single/$id';
  static const String myOrders = '$_baseUrl/orders/my-orders';
  static String myOrdersStaus(String? status) =>
      '$_baseUrl/orders/all-orders?status=$status';

  //user dashboard
  static const String userDashboard = '$_baseUrl/dashboard/user-dashboard';
  static String userCashFlowTrend(String? year) =>
      '$_baseUrl/dashboard/user-cashflow-trend?year=$year';
  static String userPropertyValueTrend(String? year) =>
      '$_baseUrl/dashboard/user-property-value-trend?year=$year';

  // saved properties
  static const String userSavedProperties =
      '$_baseUrl/properties/my-saved-property';
  // all properties
  static const String allProperties = '$_baseUrl/properties/all';
}
