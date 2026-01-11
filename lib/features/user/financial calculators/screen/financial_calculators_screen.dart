import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import '../../../../core/themes/app_colors.dart';
import '../cash flow calculator/screen/cash_flow_calculator_screen.dart';
import '../widget/financial_calculators_body_widget.dart';

class FinancialCalculatorsScreen extends StatelessWidget {
  const FinancialCalculatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
          backgroundColor: AppColors.secondaryColors,
          title: const Text('Financial Calculators')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 20,
            children: [
              FinancialCalculatorsBodyWidget(
                title: "Cash Flow Calculator",
                subTitle:'Calculate monthly and annual cash flow' ,
                image: 'assets/icons/up_graph.png',
                iconColor:AppColors.blue,
                boxColor:AppColors.greyDip ,
                containerCustomColor:AppColors.lightBlue,
                onTab: (){
                  Get.to(()=>CashFlowCalculatorScreen());
                },
              ),
              FinancialCalculatorsBodyWidget(
                title: "Income Calculator",
                subTitle:'Calculate net income and tax payable' ,
                image: 'assets/icons/dollar_Icon.png',
                iconColor:AppColors.greenDip,
                boxColor:AppColors.greenLowLight ,
                containerCustomColor:AppColors.greenDip,
                onTab: (){},
              ),
              FinancialCalculatorsBodyWidget(
                title: "Property Investment",
                subTitle:'ROI, growth forecast & tax impact' ,
                image: 'assets/icons/home3.png',
                iconColor:AppColors.indicator,
                boxColor:AppColors.accentLightMore ,
                containerCustomColor:AppColors.indicator,
                onTab: (){},
              ),
              FinancialCalculatorsBodyWidget(
                title: "Mortgage Calculator",
                subTitle:'Monthly repayments & borrowing capacity' ,
                image: 'assets/icons/calculators_icon.png',
                iconColor:AppColors.warningSecondary,
                boxColor:AppColors.infoSecondaryLight ,
                containerCustomColor:AppColors.warningSecondary,
                onTab: (){},
              ),FinancialCalculatorsBodyWidget(
                title: "Stamp Duty Calculator",
                subTitle:'Calculate stamp duty by state' ,
                image: 'assets/icons/document_icon.png',
                iconColor:AppColors.deepPink,
                boxColor:AppColors.lightDeepPink ,
                containerCustomColor:AppColors.deepPink,
                onTab: (){},
              ),FinancialCalculatorsBodyWidget(
                title: "Insurance & Council Rates",
                subTitle:'Estimate insurance and council fees' ,
                image: 'assets/icons/privacy_icon.png',
                iconColor:AppColors.lightBlueSolid,
                boxColor:AppColors.greyDip ,
                containerCustomColor:AppColors.lightBlueSolid,
                onTab: (){},
              ),
              FinancialCalculatorsBodyWidget(
                title: "Tax Calculator",
                subTitle:'Income, investment & land tax' ,
                image: 'assets/icons/dollar4.png',
                iconColor:AppColors.infoLightMore,
                boxColor:AppColors.greyAndGreen ,
                containerCustomColor:AppColors.infoLightMore,
                onTab: (){},
              ),
              FinancialCalculatorsBodyWidget(
                title: "Loan & Rate Comparison",
                subTitle:'Compare lenders and rates' ,
                image: 'assets/icons/up_graph.png',
                iconColor:AppColors.deepGrey,
                boxColor:AppColors.greyLight ,
                containerCustomColor:AppColors.deepGrey,
                onTab: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
