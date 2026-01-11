import 'package:get/get.dart';

class PropertyDropdownController extends GetxController {
  // Selected value observable (RxString)
  final RxString selectedProperty = 'Property1'.obs;

  // Dropdown এর আইটেম লিস্ট
  final List<String> properties = [
    'Property1',
    'Property2',
    'Property3',
    'Property4',
    'Property5',
    'Property6',
  ];

  // Optional: Value চেঞ্জ হলে যা করতে চাও
  void changeProperty(String? newValue) {
    if (newValue != null) {
      selectedProperty.value = newValue;
      print('Selected Property: $newValue'); // তোমার লজিক এখানে
    }
  }
}