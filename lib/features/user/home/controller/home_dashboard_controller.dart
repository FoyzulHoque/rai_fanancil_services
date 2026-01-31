import 'dart:developer';

import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/network_musfik/service.dart';
import 'package:rai_fanancil_services/core/network_path/natwork_path.dart';
import 'package:rai_fanancil_services/features/user/home/model/user_cash_flow_trend_modal.dart';
import 'package:rai_fanancil_services/features/user/home/model/user_dashboard_modal.dart';

class HomeDashboardController extends GetxController {
  final isLoading = false.obs;

  @override
  void onInit() {
    userDashboardData();
    cashFlowTrend();
    super.onInit();
  }

  final NetworkCaller networkCaller = NetworkCaller();
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NmRiYzU5ZmFhN2U2MmM4OTk0Mzk3NiIsImVtYWlsIjoicmFmc2Fuc2F5ZWQxMzJAZ21haWwuY29tIiwicm9sZSI6IlVzZXIiLCJlbWFpbFZlcmlmaWNhdGlvbiI6dHJ1ZSwiaXNGaW5hbmNpYWxQcm9maWxlQ29tcGxldGUiOnRydWUsImlhdCI6MTc2OTg0MTYzOCwiZXhwIjoxODAxMzc3NjM4fQ.Ci57ZPiOMWraRRd4XcAQZBnv5Yj4vFGLpyiBkixkIRo';
  final userDashboard = <UserDashBoardResult>[].obs;

  // user dashboard
  Future<void> userDashboardData() async {
    isLoading.value = true;
    try {
      final response = await networkCaller.getRequest(
        Urls.userDashboard,
        token: token,
      );
      log(response.responseData.toString());
      if (response.statusCode == 200 || response.isSuccess) {
        final dashboard = UserDashBoardResult.fromJson(response.responseData);

        userDashboard.assignAll([dashboard]);
      } else {
        // showError(response.errorMessage);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
      // log('user dashboard data is >>>>> $userDashboard');
    }
  }

  final cashFlowTrendData = <Datum>[].obs;
  Future<void> cashFlowTrend() async {
    isLoading.value = true;
    try {
      final response = await networkCaller.getRequest(
        Urls.userCashFlowTrend('2026'),
        token: token,
      );

      log(response.responseData.toString());
      if (response.statusCode == 200 || response.isSuccess) {
        final List list = response.responseData as List;

        final parsed = list
            .map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList();

        cashFlowTrendData.assignAll(parsed);
      } else {
        // showError(response.errorMessage);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
