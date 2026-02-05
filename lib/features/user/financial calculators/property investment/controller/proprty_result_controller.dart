import 'package:get/get.dart';
import '../models/property_summiry_model.dart';

class PropertyResultController extends GetxController {
  final Rxn<PropertyInvestmentData > result = Rxn<PropertyInvestmentData >();

  void setResult(PropertyInvestmentData  data) {
    result.value = data;
  }

  void clear() {
    result.value = null;
  }
}
