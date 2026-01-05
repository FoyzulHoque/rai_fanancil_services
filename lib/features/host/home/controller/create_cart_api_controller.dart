import 'package:get/get.dart';
import '../../../../core/network_caller/network_config.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_data_helper.dart';
class CreateCartApiController extends GetxController {
  static CreateCartApiController get to => Get.find();

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final RxString _errorMessage = "".obs;
  RxString get errorMessage => _errorMessage;

  Future<bool> createCartApiMethod({
    required String productId,
    required String price,
    required String quantity,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = "";

    try {
      final Map<String, dynamic> mapBody = {
        "productId": productId,
        //"totalQuantity": int.tryParse(quantity) ?? 1,
        "totalPrice": int.tryParse(price) ?? 0,
      };

      NetworkResponse response = await NetworkCall.postRequest(
        url: Urls.createAddToCart,
        body: mapBody,
      );

      if (response.isSuccess) {
        await AuthController.getUserData();
        // Get.snackbar("Success", "Product added to cart",
        //     backgroundColor: Colors.green, colorText: Colors.white);
        return true;
      } else {
        _errorMessage.value = response.errorMessage ?? "Failed to add to cart";
        // Get.snackbar("Failed", _errorMessage.value,
        //     backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      _errorMessage.value = "Network error occurred";
      // Get.snackbar("Error", "Something went wrong",
      //     backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
}