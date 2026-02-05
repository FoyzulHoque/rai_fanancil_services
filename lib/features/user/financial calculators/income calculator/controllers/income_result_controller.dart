import 'package:get/get.dart';
import '../model/income_summary_model.dart';

class IncomeResultController extends GetxController {
  final Rxn<IncomeSummaryData > result = Rxn<IncomeSummaryData >();

  void setResult(IncomeSummaryData  data) {
    result.value = data;
  }

  void clear() {
    result.value = null;
  }
}
