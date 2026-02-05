import 'package:get/get.dart';

import '../model/cashflow_scenario_model.dart';

class CashFlowResultController extends GetxController {
  final Rxn<CashflowScenarioData> result = Rxn<CashflowScenarioData>();

  void setResult(CashflowScenarioData data) {
    result.value = data;
  }

  void clear() {
    result.value = null;
  }
}
