import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/network_path/natwork_path.dart';
import '../models/my_property_model.dart';
import '../models/property_summiry_model.dart';
import 'proprty_result_controller.dart';
import '../screen/investment_results_screen.dart';

/// One property form holder (controllers + dropdown selections)
class PropertyFormVM {
  final TextEditingController purchasePriceCtrl = TextEditingController();
  final TextEditingController rentCtrl = TextEditingController();
  final TextEditingController loanAmountCtrl = TextEditingController();
  final TextEditingController interestRateCtrl = TextEditingController();

  /// dropdown selections
  String selectedPropertyType = "Apartment";
  String selectedSuburb = "Victoria"; // you use this as state (NSW/VIC)
  String selectedRentFrequency = "Monthly";
  String selectedLoanType = "P&I"; // "P&I" or "IO"

  /// name for API
  String name = "";

  void dispose() {
    purchasePriceCtrl.dispose();
    rentCtrl.dispose();
    loanAmountCtrl.dispose();
    interestRateCtrl.dispose();
  }
}

class PropertyCalculatorController extends GetxController {
  /// list of property forms (dynamic count)
  final RxList<PropertyFormVM> propertyForms = <PropertyFormVM>[].obs;

  /// loading states
  final isLoading = false.obs;
  final isLoadingProperty = false.obs;

  /// keep property response (optional)
  final Rxn<MyPropertyModel> myProperty = Rxn<MyPropertyModel>();

  /// Dropdown lists (keep your UI lists)
  final List<String> propertyTypes = const ["Apartment", "House", "Townhouse"];
  final List<String> suburbs = const ["Victoria", "Sydney", "Melbourne"]; // UI list only
  final List<String> rentFrequencies = const ["Monthly", "Weekly"];

  double _parseDouble(TextEditingController c) =>
      double.tryParse(c.text.trim()) ?? 0;

  @override
  void onInit() {
    super.onInit();
    fetchMyPropertyAndBuildForms(); // ✅ load + build dynamic UI fields
  }

  /// -------------------- GET MY PROPERTY (prefill forms) --------------------
  Future<void> fetchMyPropertyAndBuildForms() async {
    isLoadingProperty.value = true;

    try {
      String? token = await Urls.token;
      final url = Uri.parse("${Urls.baseUrl}/financial-profile/get-my-property");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      debugPrint("get-my-property (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        final parsed = MyPropertyModel.fromJson(decoded);

        myProperty.value = parsed;

        final details = parsed.data.propertyDetails;
        propertyForms.clear();

        if (details.isEmpty) {
          // if API returns no propertyDetails, keep at least 1 empty block
          propertyForms.add(PropertyFormVM()..name = "Property 1");
          return;
        }

        for (int idx = 0; idx < details.length; idx++) {
          final d = details[idx];
          final vm = PropertyFormVM();

          vm.name = "Property ${idx + 1}";

          // Prefill textfields (from your my_property_model)
          vm.purchasePriceCtrl.text = (d.purchasePrice).toStringAsFixed(0);

          // rentalIncome: API expects numeric, you have monthlyRentalPayment
          vm.rentCtrl.text = (d.monthlyRentalPayment).toStringAsFixed(0);

          vm.loanAmountCtrl.text = (d.currentMortgageAmount).toStringAsFixed(0);
          vm.interestRateCtrl.text =
              (d.currentMortgageInterestRate).toStringAsFixed(1);

          // propertyType mapping (Own House -> House)
          vm.selectedPropertyType = _mapPropertyType(d.type);

          // state mapping from address -> NSW/VIC if possible
          vm.selectedSuburb = _mapStateFromAddress(d.address);

          // frequency: we only have monthlyRentalPayment => Monthly
          vm.selectedRentFrequency = "Monthly";

          // loan type mapping from mortgageType / flags
          vm.selectedLoanType = _mapLoanType(d);

          propertyForms.add(vm);
        }
      } else {
        // fallback: show 2 empty blocks like your screenshot
        propertyForms.clear();
        propertyForms.add(PropertyFormVM()..name = "Property 1");
        propertyForms.add(PropertyFormVM()..name = "Property 2");
      }
    } catch (e) {
      debugPrint("fetchMyProperty error: $e");
      // fallback: show 2 empty blocks like your screenshot
      propertyForms.clear();
      propertyForms.add(PropertyFormVM()..name = "Property 1");
      propertyForms.add(PropertyFormVM()..name = "Property 2");
    } finally {
      isLoadingProperty.value = false;
    }
  }

  String _mapPropertyType(String raw) {
    final r = raw.toLowerCase();
    if (r.contains("house")) return "House";
    if (r.contains("town")) return "Townhouse";
    if (r.contains("apartment") || r.contains("unit")) return "Apartment";
    return "House";
  }

  String _mapStateFromAddress(String address) {
    // Try to detect NSW/VIC/QLD...
    final up = address.toUpperCase();
    const states = ["NSW", "VIC", "QLD", "SA", "WA", "TAS", "ACT", "NT"];
    for (final s in states) {
      if (up.contains(" $s")) return s; // return state code if found
    }
    // Your UI uses Victoria/Sydney/Melbourne list.
    // If not detected, keep "Victoria"
    return "Victoria";
  }

  String _mapLoanType(PropertyDetail d) {
    // API expects "P&I" or "IO"
    if (d.isInterestOnly == true) return "IO";
    // If mortgageType says Interest Only
    final mt = d.mortgageType.toLowerCase();
    if (mt.contains("interest") && mt.contains("only")) return "IO";
    return "P&I";
  }

  /// -------------------- POST CALCULATE PROPERTY INVESTMENT --------------------
  Future<void> createPropertyCalculator() async {
    if (propertyForms.isEmpty) {
      Get.snackbar("Error", "No properties found.");
      return;
    }

    // simple validation
    for (int i = 0; i < propertyForms.length; i++) {
      final p = propertyForms[i];
      if (p.purchasePriceCtrl.text.trim().isEmpty) {
        Get.snackbar("Error", "Enter Purchase Price for ${p.name}");
        return;
      }
      if (p.loanAmountCtrl.text.trim().isEmpty) {
        Get.snackbar("Error", "Enter Loan Amount for ${p.name}");
        return;
      }
    }

    isLoading.value = true;

    try {
      String? token = await Urls.token;

      // ✅ FIXED endpoint (your old code wrongly used /calculators/income)
      final url = Uri.parse("${Urls.baseUrl}/calculators/property-investment");

      // ✅ API payload EXACT like your input
      final payload = {
        "properties": propertyForms.map((p) {
          return {
            "name": p.name,
            "purchasePrice": _parseDouble(p.purchasePriceCtrl),
            "propertyType": p.selectedPropertyType,
            "state": p.selectedSuburb, // you treat suburb dropdown as state
            "rentalIncome": _parseDouble(p.rentCtrl),
            "rentalFrequency": p.selectedRentFrequency,
            "loanAmount": _parseDouble(p.loanAmountCtrl),
            "interestRate": _parseDouble(p.interestRateCtrl),
            "loanType": p.selectedLoanType, // "P&I" or "IO"
          };
        }).toList(),
      };

      debugPrint("Property Investment Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(payload),
      );

      debugPrint("property-investment (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final parsed =
        PropertyInvestmentResponse.fromJson(jsonDecode(response.body));

        final resultController = Get.find<PropertyResultController>();
        if (parsed.data != null) {
          resultController.setResult(parsed.data!);
        }

        Get.snackbar("Success", parsed.message ?? "Success");
        Get.to(() => InvestmentResultsScreen());
      } else {
        String msg = "Failed to calculate property investment";
        try {
          final data = jsonDecode(response.body);
          msg = data["message"]?.toString() ?? msg;
        } catch (_) {}
        Get.snackbar("Error", msg);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to calculate: $e");
      debugPrint("createPropertyCalculator error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// update dropdown selections (keep UI as-is)
  void setPropertyType(int index, String v) {
    if (index < 0 || index >= propertyForms.length) return;
    propertyForms[index].selectedPropertyType = v;
    propertyForms.refresh();
  }

  void setSuburb(int index, String v) {
    if (index < 0 || index >= propertyForms.length) return;
    propertyForms[index].selectedSuburb = v;
    propertyForms.refresh();
  }

  void setRentFrequency(int index, String v) {
    if (index < 0 || index >= propertyForms.length) return;
    propertyForms[index].selectedRentFrequency = v;
    propertyForms.refresh();
  }

  void setLoanType(int index, String v) {
    if (index < 0 || index >= propertyForms.length) return;
    propertyForms[index].selectedLoanType = v; // "P&I" or "IO"
    propertyForms.refresh();
  }

  @override
  void onClose() {
    for (final p in propertyForms) {
      p.dispose();
    }
    super.onClose();
  }
}
