import 'package:flutter/cupertino.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

class SearchingBodyHeadWidget extends StatelessWidget {
  const SearchingBodyHeadWidget({super.key, this.price1, this.price2, this.apartment});
final String? price1;
final String? price2;
final String? apartment;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          height: 40,
          width: 152,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: AppColors.primary,width: 2)
          ),
          child: Row(
            children: [
              const SizedBox(width: 4,),

              Text("Price: \$${price1}K - \$${price2}M",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.primary),),
            ],
          )
        ),Container(
          height: 40,
          width: 152,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: AppColors.primary,width: 2)
          ),
          child: Row(
            children: [
              const SizedBox(width: 4,),
              Text("$apartment",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.primary)),
            ],
          )
        ),
      ],
    );
  }
}
