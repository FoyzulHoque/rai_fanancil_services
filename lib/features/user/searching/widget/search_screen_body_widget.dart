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
    this.onTap_Add_property,
    this.onTap_Use_in_Calculator,
  });

  final String? image;
  final String? price;
  final String? location;
  final String? beds;
  final String? baths;
  final VoidCallback? onTap_Add_property;
  final VoidCallback? onTap_Use_in_Calculator;

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
              Text("$beds beds"),
              const SizedBox(width: 12),
              Text("$baths baths"),
            ],
          ),

          const Divider(),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: onTap_Add_property,
                  child: const Text("+ Add property",style: TextStyle(color: AppColors.black,fontSize: 16)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: onTap_Use_in_Calculator,
                  child: const Text("Use in Calculator",style: TextStyle(color: AppColors.white,fontSize: 16),),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

