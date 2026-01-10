import 'package:flutter/cupertino.dart';
import '../../../../../core/themes/app_colors.dart';

class ImportPropertyWidget extends StatelessWidget {
  const ImportPropertyWidget({super.key, this.onTab});
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 50,
        width: 180.98,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.infoLight,
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/upload_icon.png",
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              "Import Property",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ),

          ],
        ),

      ),
    );
  }
}

