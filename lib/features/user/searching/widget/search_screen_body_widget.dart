import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class SearchScreenBodyWidget extends StatelessWidget {
  const SearchScreenBodyWidget({
    super.key,
    this.image,
    this.price,
    this.location,
    this.beds,
    this.baths,

    this.onTapAddProperty,
    this.onTapUseInCalculator,
    required this.leftButtonText,
    required this.rightButtonText,
    this.borderColorLeft,
    this.borderColorRight,
    this.leftTextColor,
    this.rightTextColor,
  });

  final String? image;
  final String? price;
  final String? location;
  final String? beds;
  final String? baths;

  final VoidCallback? onTapAddProperty;
  final VoidCallback? onTapUseInCalculator;

  final String leftButtonText;
  final String rightButtonText;

  final Color? borderColorLeft;
  final Color? borderColorRight;
  final Color? leftTextColor;
  final Color? rightTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image ?? '',
            height: 176,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),

          Text(
            "\$$price",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              const Icon(Icons.location_on, size: 16),
              const SizedBox(width: 4),
              Expanded(child: Text(location ?? '')),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset("assets/icons/bed-alt.png",fit: BoxFit.fill)),
              const SizedBox(width: 4,),
              Text("$beds beds"),
              const SizedBox(width: 12),
              SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset("assets/icons/bath.png",fit: BoxFit.fill,)),
              const SizedBox(width: 4,),
              Text("$baths baths"),
            ],
          ),

          const Divider(),

      Row(
        children: [
          /// LEFT BUTTON
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                side: BorderSide(
                  color: borderColorLeft ?? AppColors.grey,
                ),
              ),
              onPressed: onTapAddProperty,
              child: Text(
                leftButtonText,
                style: TextStyle(
                  color: leftTextColor ?? AppColors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// RIGHT BUTTON
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                side: BorderSide(
                  color: borderColorRight ?? AppColors.primary,
                ),
              ),
              onPressed: onTapUseInCalculator,
              child: Text(
                rightButtonText,
                style: TextStyle(
                  color: rightTextColor ?? AppColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      )
        ],
      ),
    );
  }
}

