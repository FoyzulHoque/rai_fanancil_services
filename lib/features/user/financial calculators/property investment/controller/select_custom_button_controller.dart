import 'package:get/get.dart';

enum LoanType { pi, interestOnly }

class LoanTypeController extends GetxController {
  final selected = LoanType.pi.obs;



  void change(LoanType type) {
    selected.value = type;
  }

  bool isPI() => selected.value == LoanType.pi;
  bool isInterestOnly() => selected.value == LoanType.interestOnly;
}
