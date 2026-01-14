import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

Widget customContainer(Color borderColors,double borderWidth,String title,String subTitle,double containerHight,double containerWidth){
  return Container(
    height: containerHight,
    width: containerWidth,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: borderColors ,width:borderWidth ),
        color: AppColors.white
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("$title",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.grey)),
          const SizedBox(height: 2,),
          Text("$subTitle",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.black)),

        ],
      ),
    ),
  );
}