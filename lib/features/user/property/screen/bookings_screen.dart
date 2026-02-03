import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rai_fanancil_services/features/user/property/controller/saved_properties_controller.dart';
import '../../../../core/themes/app_colors.dart';
import '../../searching/widget/search_screen_body_widget.dart';

class PropertyScreen extends StatelessWidget {
  PropertyScreen({super.key});
  final SavedPropertiesController savedPropertiesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return savedPropertiesController.refreshData();
        },
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 122,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColors,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 32),
                    /*  Row(
                            children: [
                              Expanded(
                                child: SearchsWidget(),
                              ),
                              const SizedBox(width: 10),
                           */
                    /*   GestureDetector(
                                onTap: () {
                                  Get.to(()=>SearchingFilterScreen());
                                },
                                child: SizedBox(
                                  height: 46,
                                  width: 46,
                                  child: Image.asset(
                                    "assets/icons/Scan.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),*/
                    /*
                            ],
                          ),*/
                    const Text(
                      'Saved properties',
                      style: TextStyle(color: AppColors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Choose a property to get started',
                      style: TextStyle(color: AppColors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RefreshIndicator(
                  onRefresh: () {
                    return savedPropertiesController.refreshData();
                  },
                  color: AppColors.primary,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Obx(() {
                          if (savedPropertiesController.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (savedPropertiesController
                              .savedPropertiesData
                              .isEmpty) {
                            return const Center(
                              child: Text("No saved properties found"),
                            );
                          }

                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: savedPropertiesController
                                .savedPropertiesData
                                .length,
                            itemBuilder: (context, index) {
                              final item = savedPropertiesController
                                  .savedPropertiesData[index];
                              final property = item.propertyListing;

                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SearchScreenBodyWidget(
                                  image: property?.images?.isNotEmpty == true
                                      ? property!.images!.first
                                      : "",
                                  baths: property?.bathrooms?.toString() ?? "0",
                                  beds: property?.bedrooms?.toString() ?? "0",
                                  location:
                                      "${property?.address ?? ""}, ${property?.state ?? ""}",
                                  price: property?.price?.toString() ?? "0",
                                  leftButtonText: 'Remove',
                                  leftTextColor: AppColors.warningSecondary,
                                  onTapAddProperty: () {},
                                  borderColorLeft: AppColors.warningSecondary,
                                  rightButtonText: 'Use in Calculator',
                                  rightTextColor: AppColors.white,
                                  onTapUseInCalculator: () {},
                                  borderColorRight: AppColors.primary,
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
