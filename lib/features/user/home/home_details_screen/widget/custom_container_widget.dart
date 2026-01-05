import 'package:flutter/cupertino.dart';
import 'package:iconic/core/themes/app_colors.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({super.key,  this.text, this.onTabAction});
  final String? text;
  final VoidCallback? onTabAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabAction,
      child: Container(
        height: 42,
        width: 159.5,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadiusGeometry.circular(12)
        ),
      child: Center(child: Text("$text",style: TextStyle(fontSize: 16,color: AppColors.black,fontWeight: FontWeight.w400),)),),
    );
  }
}
