
import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class TaxSummaryResultWidget1 extends StatelessWidget {
  const TaxSummaryResultWidget1({super.key, this.totalTaxPayable, this.netProfitAfterTax, this.incomeTax, this.investmentTax, this.landTax});
final String? totalTaxPayable;
final String? netProfitAfterTax;
final String? incomeTax;
final String? investmentTax;
final String? landTax;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362,
      height:287 ,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: AppColors.secondaryColors,width: 2)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Total Tax Payable",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4,),
            Text(
              "$totalTaxPayable",
              style: TextStyle(
                color: AppColors.primaryDife,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4,),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Net Profit After Tax:",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4,),
                  Text(
                    "\$$netProfitAfterTax",
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Divider(color: AppColors.secondaryColors,height: 2,),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Income Tax",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 2,),
                Spacer(),
                Text(
                  "\$$incomeTax",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Investment Tax",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 2,),
                Spacer(),
                Text(
                  "\$$investmentTax",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Land Tax",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 2,),
                Spacer(),
                Text(
                  "\$$landTax",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}
