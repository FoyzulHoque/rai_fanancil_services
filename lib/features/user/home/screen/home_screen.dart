import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import 'package:rai_fanancil_services/features/user/home/controller/home_dashboard_controller.dart';
import '../../profile/my_profile/controller/my_profile_controller.dart';
import '../widget/body_graph_widget01.dart';
import '../widget/body_graph_widget02.dart';
import '../widget/body_widget01.dart';
import '../widget/body_widget02.dart';
import '../widget/home_app_bar_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeDashboardController homeDashboardController = Get.find();
  final ProfileApiController profileApiController = Get.put(ProfileApiController());

  @override
  Widget build(BuildContext context) {
    final urlClt = profileApiController.userProfile;

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => homeDashboardController.refreshData(),
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return HomeAppBarWidget(
                  name: "${urlClt.value.firstName} ${urlClt.value.lastName}",
                  imageUrl: "${urlClt.value.profileImage}",
                );
              }),

              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    // ✅ top stats row (Total Properties, Active Loans)
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            final data = homeDashboardController.userDashboard;
                            final totalProps = data.isEmpty ? 0 : data.first.totalProperties;

                            return UserBodyWidget(
                              boxColor: Colors.white,
                              image: Icons.home,
                              title: "Total Properties",
                              totalNumber: totalProps.toString(),
                              iconColor: AppColors.primary,
                            );
                          }),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(() {
                            final data = homeDashboardController.userDashboard;
                            final loans = data.isEmpty ? 0 : data.first.totalActiveLoans;

                            return UserBodyWidget(
                              boxColor: Colors.white,
                              image: Icons.monetization_on_outlined,
                              title: "Active Loans",
                              totalNumber: loans.toString(),
                              iconColor: AppColors.greenDip,
                            );
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ✅ Monthly Cashflow card
                    Obx(() {
                      final data = homeDashboardController.userDashboard;
                      if (data.isEmpty) return const SizedBox();

                      final monthly = data.first.comparisons!.monthlyCashflow!;
                      return BodyWidget02(
                        containerColor: Color(0xFFB8DBF1).withOpacity(0.4),
                        borderColor:  Color(0xFFB8DBF1).withOpacity(0.4),
                        boxColor: Colors.transparent,
                        iconColor: monthly.isIncrease! ? AppColors.greenDip : AppColors.red,
                        textColor3: monthly.isIncrease! ? AppColors.greenDip : AppColors.red,
                        title: "Monthly Cashflow",
                        image: monthly.isIncrease!
                            ? "assets/icons/up_graph.png"
                            : "assets/icons/down_graph.png",
                        totalAmount: "\$${monthly.value!.toStringAsFixed(0)}",
                        totalPercent: "${monthly.changePercentage!.toStringAsFixed(2)}%",
                        totalPercentText: "vs last month",
                      );
                    }),

                    const SizedBox(height: 10),

                    // ✅ Annual Cashflow card
                    Obx(() {
                      final data = homeDashboardController.userDashboard;
                      if (data.isEmpty) return const SizedBox();

                      final annual = data.first.comparisons!.annualCashflow!;
                      return BodyWidget02(
                        containerColor: Colors.white,
                        borderColor: const Color(0xFF24BAED),
                        boxColor: Colors.transparent,
                        iconColor: annual.isIncrease! ? AppColors.greenDip : AppColors.red,
                        textColor3: annual.isIncrease! ? AppColors.greenDip : AppColors.red,
                        title: "Annual Cashflow",
                        image: annual.isIncrease!
                            ? "assets/icons/up_graph.png"
                            : "assets/icons/down_graph.png",
                        totalAmount: "\$${annual.value!.toStringAsFixed(0)}",
                        totalPercent: "${annual.changePercentage!.toStringAsFixed(2)}%",
                        totalPercentText: "vs last year",
                      );
                    }),

                    const SizedBox(height: 10),

                    // ✅ Cashflow Trend graph
                    Obx(() {
                      final data = homeDashboardController.cashFlowTrendData;
                      if (data.isEmpty) return const SizedBox();

                      final graphData = data.map((e) {
                        return {
                          'month': e.date ?? '',
                          'amount': e.monthlyCashflow ?? 0,
                        };
                      }).toList();

                      return BodyGraphWidget01(
                        title: "Cashflow Trend",
                        monthlyData: graphData,
                        lineColor: AppColors.primary,
                        fillOpacity: 0.20,
                      );
                    }),

                    const SizedBox(height: 10),

                    // ✅ Property Value Growth graph
                    Obx(() {
                      final data = homeDashboardController.propertyValueData;
                      if (data.isEmpty) return const SizedBox();

                      final graphData = data.map((e) {
                        return {
                          'month': e.date ?? '',
                          'amount': e.propertyValue ?? 0,
                        };
                      }).toList();

                      return PropertyValueGrowthChart(
                        title: "Property Value Growth",
                        monthlyData: graphData,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
