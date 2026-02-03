import 'package:flutter/material.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import 'package:rai_fanancil_services/features/user/home/controller/home_dashboard_controller.dart';
import '../../profile/my_profile/controller/my_profile_controller.dart';
import '../widget/body_graph_widget01.dart';
import '../widget/body_graph_widget02.dart';
import '../widget/body_widget01.dart';
import '../widget/body_widget02.dart';
import '../widget/home_app_bar_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeDashboardController homeDashboardController = Get.find();
  final ProfileApiController profileApiController = Get.put(
    ProfileApiController(),
  );

  // List<Map<String, dynamic>> cashflowData = [
  //   {'month': 'Jan', 'amount': 4500},
  //   {'month': 'Feb', 'amount': 4300},
  //   {'month': 'Mar', 'amount': 4000},
  //   {'month': 'Apr', 'amount': 4200},
  //   {'month': 'May', 'amount': 4800},
  //   {'month': 'Jun', 'amount': 5500},
  //   {'month': 'Jul', 'amount': 6200},
  //   {'month': 'Aug', 'amount': 5800},
  // ];

  @override
  Widget build(BuildContext context) {
    final urlClt = profileApiController.userProfile;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return homeDashboardController.refreshData();
        },
        color: AppColors.primary,
        child: SingleChildScrollView(
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Obx(() {
                          final data = homeDashboardController.userDashboard;

                          if (data.isEmpty) {
                            return UserBodyWidget(
                              boxColor: AppColors.thirdColors,
                              image: "assets/icons/home2.png",
                              title: "Total Properties",
                              totalNumber: "0",
                              iconColor: AppColors.primary,
                            );
                          }

                          return UserBodyWidget(
                            boxColor: AppColors.thirdColors,
                            image: "assets/icons/home2.png",
                            title: "Total Properties",
                            totalNumber: data.first.totalProperties.toString(),
                            iconColor: AppColors.primary,
                          );
                        }),

                        Spacer(),
                        Obx(() {
                          final data = homeDashboardController.userDashboard;

                          if (data.isEmpty) {
                            return UserBodyWidget(
                              boxColor: AppColors.thirdColors,
                              image: "assets/icons/home2.png",
                              title: "Total Properties",
                              totalNumber: "0",
                              iconColor: AppColors.primary,
                            );
                          }

                          return UserBodyWidget(
                            boxColor: AppColors.thirdColors,
                            image: "assets/icons/dollar_Icon.png",
                            title: "Total Loans",
                            totalNumber: data.first.totalActiveLoans.toString(),
                            iconColor: AppColors.primary,
                          );
                        }),
                      ],
                    ),

                    Obx(() {
                      final data = homeDashboardController.userDashboard;

                      if (data.isEmpty) {
                        return const SizedBox();
                      }

                      final monthly = data.first.comparisons!.monthlyCashflow;

                      return BodyWidget02(
                        containerColor: AppColors.veryLightCyanBlueColor,
                        borderColor: Colors.grey.shade300,
                        boxColor: monthly!.isIncrease!
                            ? AppColors.greenLowLight
                            : AppColors.peachPuff,
                        iconColor: monthly.isIncrease!
                            ? Colors.green
                            : AppColors.red,
                        textColor3: monthly.isIncrease!
                            ? Colors.green
                            : Colors.red,
                        title: "Monthly Cashflow",
                        image: monthly.isIncrease!
                            ? "assets/icons/up_graph.png"
                            : "assets/icons/down_graph.png",
                        totalAmount: "\$${monthly.value!.toStringAsFixed(2)}",
                        totalPercent:
                            "${monthly.changePercentage!.toStringAsFixed(2)}%",
                        totalPercentText: "last month",
                      );
                    }),

                    // BodyWidget02(
                    //   containerColor: AppColors.veryLightCyanBlueColor,
                    //   borderColor: Colors.grey.shade300,
                    //   boxColor: AppColors.peachPuff,
                    //   iconColor: AppColors.red,
                    //   textColor3: Colors.red,
                    //   title: "Annual Cashflow",
                    //   image: "assets/icons/down_graph.png",
                    //   totalAmount: "\$58,200",
                    //   totalPercent: "-8.3%",
                    //   totalPercentText: "last month",
                    // ),
                    Obx(() {
                      final data = homeDashboardController.userDashboard;
                      if (data.isEmpty) return const SizedBox();

                      final annual = data.first.comparisons!.annualCashflow;

                      return BodyWidget02(
                        containerColor: AppColors.veryLightCyanBlueColor,
                        borderColor: Colors.grey.shade300,
                        boxColor: annual!.isIncrease!
                            ? AppColors.greenLowLight
                            : AppColors.peachPuff,
                        iconColor: annual.isIncrease!
                            ? Colors.green
                            : AppColors.red,
                        textColor3: annual.isIncrease!
                            ? Colors.green
                            : Colors.red,
                        title: "Annual Cashflow",
                        image: annual.isIncrease!
                            ? "assets/icons/up_graph.png"
                            : "assets/icons/down_graph.png",
                        totalAmount: "\$${annual.value!.toStringAsFixed(0)}",
                        totalPercent:
                            "${annual.changePercentage!.toStringAsFixed(2)}%",
                        totalPercentText: "last month",
                      );
                    }),

                    // BodyGraphWidget01(
                    //   title: "Cash Flow Trend",
                    //   monthlyData: cashflowData,
                    //   lineColor: Colors.cyan,
                    //   fillOpacity: 0.3,
                    // ),
                    Obx(() {
                      final data = homeDashboardController.cashFlowTrendData;

                      if (data.isEmpty) {
                        return const SizedBox();
                      }

                      final graphData = data.map((e) {
                        return {
                          'month': e.date ?? '',
                          'amount': e.monthlyCashflow ?? 0,
                        };
                      }).toList();

                      return BodyGraphWidget01(
                        title: "Cash Flow Trend",
                        monthlyData: graphData,
                        lineColor: Colors.cyan,
                        fillOpacity: 0.3,
                      );
                    }),

                    // PropertyValueGrowthChart(
                    //   title: "Property Value Growth",
                    //   monthlyData: [
                    //     {'month': 'Jan', 'amount': 450000},
                    //     {'month': 'Feb', 'amount': 520000},
                    //     {'month': 'Mar', 'amount': 850000},
                    //     {'month': 'Apr', 'amount': 920000},
                    //     {'month': 'May', 'amount': 780000},
                    //     {'month': 'Jun', 'amount': 650000},
                    //   ],
                    // ),
                    Obx(() {
                      final data = homeDashboardController.propertyValueData;

                      if (data.isEmpty) {
                        return const SizedBox();
                      }

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
