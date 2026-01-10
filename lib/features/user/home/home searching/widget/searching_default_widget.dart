import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../searching/widget/search_widget.dart';
import '../../widget/user_home_search_widget.dart';

class SearchingDefaultWidget extends StatelessWidget {
  const SearchingDefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:702 ,
      width: 375,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 24.0,bottom: 8.0),
            child: SearchWidget(),
          )
        ],
      ),
    );
  }
}
