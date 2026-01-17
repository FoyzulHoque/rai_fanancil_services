import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';
import '../../../../core/widgets/custom_input_field_widget.dart';
import '../controller/property_details_controller.dart';
import '../widget/custom_app_bar_set_before_nave_bar.dart';
import 'liabilities.dart';

class AssetsScreen extends StatelessWidget {
  AssetsScreen({super.key});

  TextEditingController propertyController = TextEditingController();

  // final PropertyController propertyController = Get.put(PropertyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          CustomAppBarSetBeforeNaveBar(
            title: "Property Details",
            currentStep: 5,
            totalSteps: 6,
            appBarColor: AppColors.secondaryColors,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      height: 92,
                      width: 361,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDife,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Assets",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$ 0",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    //---input field-----------------------
                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*Text(
                              "Monthly Mortgage Payment",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),*/
                            const SizedBox(height: 8),
                            Text(
                              "Bank Name",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.monetization_on_outlined,
                              ),
                              controller: propertyController,
                              keyboardType: TextInputType.number,
                              hintText: "e,g,, CommonWealth Bank",
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Account Type",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              controller: propertyController,
                              keyboardType: TextInputType.number,
                              hintText: "e,g,, Saving Account",
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Interest Rate",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(Icons.calculate),
                              controller: propertyController,
                              keyboardType: TextInputType.number,
                              hintText: "e,g,, Saving Account",
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 39.98,
                                  width: 39.98,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.infoLight,
                                  ),
                                  child: SizedBox(
                                    height: 14,
                                    width: 10,
                                    child: Image.asset(
                                      "assets/icons/Wallet@4x.png",
                                      color: AppColors.primaryDife,
                                      fit: BoxFit.cover,
                                      height: 14,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cash & Savings",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Bank Name",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.monetization_on_outlined,
                              ),
                              controller: propertyController,
                              keyboardType: TextInputType.number,
                              hintText: "0",
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 39.98,
                                  width: 39.98,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.greenLowLight,
                                  ),
                                  child: SizedBox(
                                    height: 14,
                                    width: 10,
                                    child: Image.asset(
                                      "assets/icons/up_graph.png",
                                      color: AppColors.greenDip,
                                      fit: BoxFit.cover,
                                      height: 14,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Investments",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Shares, managed funds, ETFs",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.monetization_on_outlined,
                              ),
                              controller: propertyController,
                              keyboardType: TextInputType.number,
                              hintText: "0",
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 39.98,
                                  width: 39.98,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.infoLight,
                                  ),
                                  child: SizedBox(
                                    height: 14,
                                    width: 10,
                                    child: Image.asset(
                                      "assets/icons/money_sine.png",
                                      color: AppColors.primary,
                                      fit: BoxFit.cover,
                                      height: 14,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Superannuation",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Total super balance across all funds",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.monetization_on_outlined,
                              ),
                              controller: propertyController,
                              keyboardType: TextInputType.number,
                              hintText: "0",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Card(
                      elevation: 5,
                      color: AppColors.white,
                      shape: const Border(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 39.98,
                                  width: 39.98,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.infoSecondaryLight,
                                  ),
                                  child: SizedBox(
                                    height: 14,
                                    width: 10,
                                    child: Image.asset(
                                      "assets/icons/Package.png",
                                      color: AppColors.red,
                                      fit: BoxFit.cover,
                                      height: 14,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Other Assets",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Vehicles, collectibles, valuables",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              prefixIcon: const Icon(
                                Icons.monetization_on_outlined,
                              ),
                              controller: propertyController,
                              keyboardType: TextInputType.number,
                              hintText: "0",
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Validate all fields
                 Get.to(() => LiabilitiesScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
