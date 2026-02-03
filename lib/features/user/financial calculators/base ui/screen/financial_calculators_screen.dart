import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../borrowing health calcuator/screen/borrowing_health_calculator_screen.dart';
import '../../cash flow calculator/screen/cash_flow_calculator_screen.dart';
import '../../income calculator/screen/income_calculator.dart';
import '../../insurance & council rates/screen/insurance_&_council_rates.dart';
import '../../loan & comparison/screen/loan_&_comparison.dart';
import '../../mortage calculator/screen/mortage_calculator.dart';
import '../../property investment/screen/property_investment.dart';
import '../../stamp duty calculator/screen/stamp_duty_calculator.dart';
import '../../suburb_profile_screen/screen/suburb_profile_screen.dart';
import '../../tax calculator/screen/tax_calculator.dart';
import '../widget/financial_calculators_body_widget.dart';

class FinancialCalculatorsScreen extends StatelessWidget {
  const FinancialCalculatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
          backgroundColor: AppColors.secondaryColors,
          title: Column(
            children: [
              const Text('Financial Calculators', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
              const Text('Choose a calculator to get started', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),),
            ],
          )),
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
                onTab: (){
                  Get.to(()=>IncomeCalculatorScreen());
                },
              ),
              FinancialCalculatorsBodyWidget(
                title: "Property Investment",
                subTitle:'ROI, growth forecast & tax impact' ,
                image: 'assets/icons/home3.png',
                iconColor:AppColors.indicator,
                boxColor:AppColors.accentLightMore ,
                containerCustomColor:AppColors.indicator,
                onTab: (){
                  Get.to(()=>PropertyInvestmentScreen());
                },
              ),
              FinancialCalculatorsBodyWidget(
                title: "Mortgage Calculator",
                subTitle:'Monthly repayments & borrowing capacity' ,
                image: 'assets/icons/calculators_icon.png',
                iconColor:AppColors.warningSecondary,
                boxColor:AppColors.infoSecondaryLight ,
                containerCustomColor:AppColors.warningSecondary,
                onTab: (){
                  Get.to(()=>MortgageCalculatorScreen());
                },
              ),FinancialCalculatorsBodyWidget(
                title: "Stamp Duty Calculator",
                subTitle:'Calculate stamp duty by state' ,
                image: 'assets/icons/document_icon.png',
                iconColor:AppColors.deepPink,
                boxColor:AppColors.lightDeepPink ,
                containerCustomColor:AppColors.deepPink,
                onTab: (){
                  Get.to(()=>StampDutyCalculatorScreen());
                },
              ),FinancialCalculatorsBodyWidget(
                title: "Insurance & Council Rates",
                subTitle:'Estimate insurance and council fees' ,
                image: 'assets/icons/privacy_icon.png',
                iconColor:AppColors.lightBlueSolid,
                boxColor:AppColors.greyDip ,
                containerCustomColor:AppColors.lightBlueSolid,
                onTab: (){
                  Get.to(()=>InsuranceAndCouncilRatesScreen());
                },
              ),
              FinancialCalculatorsBodyWidget(
                title: "Tax Calculator",
                subTitle:'Income, investment & land tax' ,
                image: 'assets/icons/profile_icons.jpg',
                iconColor:AppColors.infoLightMore,
                boxColor:AppColors.primaryDife ,
                containerCustomColor:AppColors.primaryDife,
                onTab: (){
                  Get.to(()=>TaxCalculatorScreen());
                },
              ),
              FinancialCalculatorsBodyWidget(
                title: "Borrowing Health Calculator",
                subTitle:'Assess you borrowing power & \ncapacity' ,
                image: 'assets/icons/Icon_favorite.png',
                iconColor:AppColors.infoLightMore,
                boxColor:AppColors.greyAndGreen ,
                containerCustomColor:AppColors.infoLightMore,
                onTab: (){
                  Get.to(()=>BorrowingOverviewResultScreen());
                },
              ),
              FinancialCalculatorsBodyWidget(
                title: "Suburb Profile",
                subTitle:'Market insights and demographics' ,
                image: 'assets/icons/tax_icons.jpg',
                iconColor:AppColors.infoLightMore,
                boxColor:AppColors.greyAndGreen ,
                containerCustomColor:Color(0xFF009689),
                onTab: (){
                  Get.to(()=>SuburbProfileScreen());
                },
              ),
              FinancialCalculatorsBodyWidget(
                title: "Loan & Rate Comparison",
                subTitle:'Compare lenders and rates' ,
                image: 'assets/icons/up_graph.png',
                iconColor:AppColors.deepGrey,
                boxColor:AppColors.greyLight ,
                containerCustomColor:AppColors.deepGrey,
                onTab: (){
                  Get.to(()=>LoanAndComparisonScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
