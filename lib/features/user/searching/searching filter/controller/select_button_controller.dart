import 'package:get/get.dart';

class SearchingFilterController extends GetxController {
  // Property type list (your UI is using this)
  final List<String> items = const [
    "House",
    "Apartment",
    "Townhouse",
    "Unit",
    "Land",
  ];

  final RxString selectedPropertyType = ''.obs;

  // optional: store location searchTerm (if you want)
  final RxString selectedLocation = ''.obs;

  void selectItem(String item) {
    selectedPropertyType.value = item;
  }

  void setLocation(String v) {
    selectedLocation.value = v.trim();
  }

  void reset() {
    selectedPropertyType.value = '';
    selectedLocation.value = '';
  }
}
