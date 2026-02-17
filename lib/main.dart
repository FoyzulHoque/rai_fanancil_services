// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/get x dependency injection/get_x_dependency_injection.dart';
import 'features/splash/splash_screen.dart';
import 'features/user/financial calculators/cash flow calculator/controller/cashflow_result_controller.dart';
import 'features/user/financial calculators/income calculator/controllers/income_result_controller.dart';
import 'features/user/financial calculators/property investment/controller/proprty_result_controller.dart';
import 'features/user/financial data collection/controller/financial_profile_controller.dart';
import 'features/user/financial data collection/view/set_up_your_financial_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CashFlowResultController(), permanent: true);
  Get.put(FinancialProfileController(), permanent: true);
  Get.put(IncomeResultController(), permanent: true);
  Get.put(PropertyResultController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rai Fanancil Services',
      debugShowCheckedModeBanner: false,

      initialBinding: GetXDependencyInjection(),

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.urbanistTextTheme(
          const TextTheme(
            bodyLarge: TextStyle(color: Colors.black87),
            bodyMedium: TextStyle(color: Colors.black54),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
        home:   SplashScreen(),//SetUpYourFinancialProfile(),
            builder: EasyLoading.init(), // Add this line

    );
  }
}