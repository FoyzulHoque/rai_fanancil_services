class Urls {
  static const String baseUrl = 'http://10.0.30.177:12030/api/v1'; // Re-check this IP and port

  // Auth URLs
  static const String login = '$baseUrl/auth/login';
  static const String authSignUp = '$baseUrl/auth/register';
  static const String authForgetSendOtp = '$baseUrl/auth/forgot-password';
  static const String authFVerifyOtp = '$baseUrl/auth/verify-otp';
  static const String authResendOtp = '$baseUrl/auth/resend-otp';
  static const String authForgetResetPassword = '$baseUrl/auth/reset-password';
  static const String authVerifyOtp = '$baseUrl/auth/verify-otp';

  // User URLs
  static const String getUserDataUrl = '$baseUrl/users/profile';
  static const String editUserDataUrl = '$baseUrl/users/update-profile';
  static const String addressCreateUrl = '$baseUrl/address/create';
  static const String getAllAddressCreateUrl = '$baseUrl/address/my-address';
  static  String getSingleAddressCreateUrl(String id) => '$baseUrl/address/my-address/$id';
  static  String deleteSingleAddressCreateUrl(String id) => '$baseUrl/address/delete/$id';
  static  String updateSingleAddressCreateUrl(String id) => '$baseUrl/address/update/$id';
  static const String logout = '$baseUrl/profile/logout';
  static const String deleteUserDataUrl = '$baseUrl/auth/delete-user';
  static const String userChangePassword = '$baseUrl/change-password';


  // Product URLs
  static const String allProduct = '$baseUrl/products/all';
  static  String allProductSearch(String? query) => '$baseUrl/products/all?searchTerm=$query';
  static  String singleProductId(String id) => '$baseUrl/products/single/$id';
  static  String deleteProductId(String id) => '$baseUrl/products/delete/$id';

  //Add to Cart
  static const String  createAddToCart='$baseUrl/add-to-cart/create';
  static const String  myCartsAddToCart='$baseUrl/add-to-cart/my-carts';
  static  String  singleAddToCart(String id)=>'$baseUrl/add-to-cart/single/$id';
  static  String  addToCartUpdateId(String? id)=>'$baseUrl/add-to-cart/update/$id';
  static  String  addToCartDeleteId(String? id)=>'$baseUrl/add-to-cart/delete/$id';

  //Order
  static const String  createOrder='$baseUrl/orders/create';
  static  String  singleOrderId(String id)=>'$baseUrl/orders/single/$id';
  static const String  myOrders='$baseUrl/orders/my-orders';
  static  String  myOrdersStaus(String? status)=>'$baseUrl/orders/all-orders?status=$status';
}