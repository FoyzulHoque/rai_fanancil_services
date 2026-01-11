import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../../../core/themes/app_colors.dart';
import '../../searching/searching filter/screen/searching_filter_screen.dart';
import '../../searching/widget/search_screen_body_widget.dart';
import '../../searching/widget/search_widget.dart';

class PropertyScreen extends StatelessWidget {
  PropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SearchsWidget(),
                          const SizedBox(width: 10),
                          GestureDetector(
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
                          ),
                        ],
                      ),
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

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child:SearchScreenBodyWidget(
                          image: "https://i.postimg.cc/bJKgPdZg/Image-(128-Park-Avenue).png",
                          baths: "3",
                          beds: "4",
                          location: "128 Park Avenue, Melbourne, VIC",
                          price: "950,000",
                          leftButtonText: '*Remove',
                          leftTextColor:AppColors.warningSecondary ,
                          onTapAddProperty: (){},
                          borderColorLeft: AppColors.warningSecondary,
                          rightButtonText: 'Use in Calculator',
                          rightTextColor: AppColors.white,
                          onTapUseInCalculator: (){},
                          borderColorRight: AppColors.primary,
                        ),
                      );
                    }
                    ,
                  )
                ]
            ),
          )
      ),
    );
  }
}
