import 'package:get/get.dart';

class SearchingFilterController extends GetxController {
  final RxString selectedPropertyType = "Apartment".obs;

  final List<String> items = [
    "House",
    "Apartment",
    "Townhouse",
    "Unit",
    "Land",
  ];

  void selectItem(String value) {
    selectedPropertyType.value = value;
  }

  void reset() {
    selectedPropertyType.value = "Apartment";
  }
}
