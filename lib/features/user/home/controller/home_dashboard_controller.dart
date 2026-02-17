import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rai_fanancil_services/core/network_musfik/service.dart';
import 'package:rai_fanancil_services/core/network_path/natwork_path.dart';
import 'package:rai_fanancil_services/features/user/home/model/user_cash_flow_trend_modal.dart';
import 'package:rai_fanancil_services/features/user/home/model/user_dashboard_modal.dart';
import 'package:rai_fanancil_services/features/user/home/model/user_property_value_trend_modal.dart';

class HomeDashboardController extends GetxController {
  final isLoading = false.obs;

  @override
  void onInit() {
    userDashboardData();
    propertyValueTrend();
    super.onInit();
  }

  Future<void> refreshData() async {
    await Future.wait([
      userDashboardData(),
      propertyValueTrend(),
    ]);
  }

  final NetworkCaller networkCaller = NetworkCaller();
  final userDashboard = <UserDashBoardResult>[].obs;

  // user dashboard
  Future<void> userDashboardData() async {
    final token = await Urls.token;
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


  final propertyValueData = <UserPropertyValueDetum>[].obs;
  Future<void> propertyValueTrend() async {
    final token = await Urls.token;
    isLoading.value = true;
    try {
      final response = await networkCaller.getRequest(
        Urls.userPropertyValueTrend('2026'),
        token: token,
      );

      log(response.responseData.toString());
      if (response.statusCode == 200 || response.isSuccess) {
        if (response.statusCode == 200 || response.isSuccess) {
          final List list = response.responseData as List;

          final parsed = list
              .map(
                (e) =>
                    UserPropertyValueDetum.fromJson(e as Map<String, dynamic>),
              )
              .toList();

          propertyValueData.assignAll(parsed);
        }
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
