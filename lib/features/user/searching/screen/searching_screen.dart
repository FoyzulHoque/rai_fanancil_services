import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../../../core/themes/app_colors.dart';
import '../searching filter/screen/searching_filter_screen.dart';
import '../widget/search_screen_body_widget.dart';
import '../widget/search_widget.dart';
import '../widget/searching_body_head_widget.dart';

class SearchingScreen extends StatelessWidget {
  SearchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 158,
        backgroundColor: AppColors.secondaryColors,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Property Search',
              style: TextStyle(color: AppColors.white, fontSize: 22),
            ),
            const SizedBox(height: 12),
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
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                  SearchingBodyHeadWidget(
                    price1: "500",
                    price2: "1",
                    apartment: "Apartment",
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SearchScreenBodyWidget(
                            image: "https://i.postimg.cc/bJKgPdZg/Image-(128-Park-Avenue).png",
                            baths: "3",
                            beds: "4",
                            location: "128 Park Avenue, Melbourne, VIC",
                            price: "950,000",
                            leftButtonText: '+Add property',
                            leftTextColor:AppColors.black ,
                            onTapAddProperty: (){},
                            borderColorLeft: AppColors.grey,
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
