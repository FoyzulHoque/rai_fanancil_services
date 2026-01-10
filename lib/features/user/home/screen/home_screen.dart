import 'package:flutter/material.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../widget/body_graph_widget01.dart';
import '../widget/body_graph_widget02.dart';
import '../widget/body_widget01.dart';
import '../widget/body_widget02.dart';
import '../widget/home_app_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> cashflowData = [
    {'month': 'Jan', 'amount': 4500},
    {'month': 'Feb', 'amount': 4300},
    {'month': 'Mar', 'amount': 4000},
    {'month': 'Apr', 'amount': 4200},
    {'month': 'May', 'amount': 4800},
    {'month': 'Jun', 'amount': 5500},
    {'month': 'Jul', 'amount': 6200},
    {'month': 'Aug', 'amount': 5800},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBarWidget(
              name: "Zaid Al-Rifai",
              imageUrl: "https://i.postimg.cc/Y9gNQbDT/Image-(16).png",
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    children: [
                      UserBodyWidget(
                        boxColor: AppColors.thirdColors,
                        image: "assets/icons/home2.png",
                        title: "Total Properties",
                        totalNumber: "12",
                        iconColor: AppColors.primary,
                      ),
                      Spacer(),
                      UserBodyWidget(
                        boxColor: AppColors.greenLowLight,
                        image: "assets/icons/dollar_Icon.png",
                        title: "Total Properties",
                        totalNumber: "8",
                        iconColor: AppColors.greenDip,
                      ),
                    ],
                  ),

                  BodyWidget02(
                    containerColor: AppColors.veryLightCyanBlueColor,
                    borderColor: Colors.grey.shade300,
                    boxColor: AppColors.greenLowLight,
                    iconColor: Colors.green,
                    textColor3: Colors.green,
                    title: "Monthly Cashflow",
                    image: "assets/icons/up_graph.png",
                    totalAmount: "\$5,400",
                    totalPercent: "+12.5%",
                    totalPercentText: "last month",
                  ),
                  BodyWidget02(
                    containerColor: AppColors.veryLightCyanBlueColor,
                    borderColor: Colors.grey.shade300,
                    boxColor: AppColors.peachPuff,
                    iconColor: AppColors.red,
                    textColor3: Colors.red,
                    title: "Annual Cashflow",
                    image: "assets/icons/down_graph.png",
                    totalAmount: "\$58,200",
                    totalPercent: "-8.3%",
                    totalPercentText: "last month",
                  ),
                  BodyGraphWidget01(
                    title: "Cash Flow Trend",
                    monthlyData: cashflowData,
                    lineColor: Colors.cyan,
                    fillOpacity: 0.3,
                  ),
                  PropertyValueGrowthChart(
                    title: "Property Value Growth",
                    monthlyData: [
                      {'month': 'Jan', 'amount': 450000},
                      {'month': 'Feb', 'amount': 520000},
                      {'month': 'Mar', 'amount': 850000},
                      {'month': 'Apr', 'amount': 920000},
                      {'month': 'May', 'amount': 780000},
                      {'month': 'Jun', 'amount': 650000},
                    ],
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
