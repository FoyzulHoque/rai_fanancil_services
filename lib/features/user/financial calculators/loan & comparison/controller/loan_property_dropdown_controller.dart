import 'package:get/get.dart';

import '../../property investment/controller/my_property_controller.dart';
import '../../property investment/models/my_property_model.dart';

class LoanPropertyDropdownController extends GetxController {
  final MyPropertyController propertyController = Get.put(MyPropertyController());

  // dropdown labels
  final RxList<String> properties = <String>[].obs;

  // map label -> propertyId
  final RxMap<String, String> labelToId = <String, String>{}.obs;

  final RxString selectedProperty = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // ✅ listen to correct observable
    ever<MyPropertyModel?>(propertyController.property, (_) => _buildDropdown());

    // if already loaded
    _buildDropdown();
  }

  void _buildDropdown() {
    final MyPropertyModel? model = propertyController.property.value;
    final details = model?.data.propertyDetails ?? [];

    properties.clear();
    labelToId.clear();

    if (details.isEmpty) {
      selectedProperty.value = '';
      return;
    }

    for (int i = 0; i < details.length; i++) {
      final PropertyDetail p = details[i];
      final label = "Property ${i + 1}";
      properties.add(label);
      labelToId[label] = p.id; // ✅ pass real propertyId
    }

    selectedProperty.value = properties.first;
  }

  void changeProperty(String? v) {
    if (v == null) return;
    selectedProperty.value = v;
  }

  String? selectedPropertyId() {
    final label = selectedProperty.value;
    return labelToId[label];
  }
}
