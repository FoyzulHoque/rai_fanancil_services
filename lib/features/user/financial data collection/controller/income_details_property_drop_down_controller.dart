import 'package:get/get.dart';


class IncomeDetailsPropertyDropdownController extends GetxController {
  // RxList<String> hishebe declare koro (observable)
  final RxList<String> properties = <String>[].obs;  // .obs add koro – eta RxList banay

  // Optional: nullable selected value (previous suggestion hishebe)
  final Rx<String?> selectedProperty = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();

    // Static list load koro (ba API theke asle eta async koro)
    properties.addAll([
      "Annually",
      "Weekly",
      "Fortnightly",
      "Monthly",
      // Add your real items here
    ]);

    // Optional: default select
    if (properties.isNotEmpty) {
      selectedProperty.value = properties.first;
    }
  }

  void changeProperty(String? newValue) {
    selectedProperty.value = newValue;
  }
}