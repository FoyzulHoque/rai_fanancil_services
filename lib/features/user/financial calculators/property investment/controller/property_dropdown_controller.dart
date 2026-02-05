import 'package:get/get.dart';

class PropertyInvesmentsDropdownController extends GetxController {
  final RxList<String> properties = <String>[].obs;
  final RxString selectedProperty = "".obs;

  void setPropertyList(List<String> list) {
    final unique = <String>[];
    for (final x in list) {
      final v = x.trim();
      if (v.isEmpty) continue;
      if (!unique.contains(v)) unique.add(v);
    }

    properties.assignAll(unique);

    if (properties.isEmpty) {
      selectedProperty.value = "";
    } else {
      if (!properties.contains(selectedProperty.value)) {
        selectedProperty.value = properties.first;
      }
    }
  }

  void changeProperty(String? v) {
    if (v == null) return;
    if (!properties.contains(v)) return;
    selectedProperty.value = v;
  }
}
