// lib/core/user navbar/navbar_controller.dart
import 'package:get/get.dart';

class UserBottomNavbarController extends GetxController {
  var currentIndex = 0.obs;

  // Holds the ID of the last product added to cart
  var lastAddedProductId = Rxn<String>();
  var lastAddedProductPrice = Rxn<String>();
  var lastAddedProductQut = Rxn<String>();

  UserBottomNavbarController([int initialIndex = 0]) {
    currentIndex.value = initialIndex;
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void financialCalculatorsScreen() {
    changeIndex(1); // Cart is at index 1
  }


  /* // Navigate to Cart tab and save product ID
  void FinancialCalculatorsScreen({String? productId,String? price,String?qut}) {
    changeIndex(1); // Cart is at index 1
  }*/

  // Navigate to Order tab (index 2, assuming Order is 3rd tab)
  void goToOrder() {
    changeIndex(2); // Change 2 to your Order tab index
  }
  void goToProfile() {
    changeIndex(3); // Change 2 to your Order tab index
  }

  void clearLastAddedProduct() {
    lastAddedProductId.value = null;
  }
}