import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../controller/pricing_controller.dart';

class PriceRangeWidget extends StatelessWidget {
  final String tag;

  const PriceRangeWidget({super.key, required this.tag});

  PriceRangeController get c =>
      Get.find<PriceRangeController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => RangeSlider(
          min: c.minLimit,
          max: c.maxLimit,
          divisions: 100,
          activeColor: AppColors.primary,
          values: RangeValues(
            c.minPrice.value,
            c.maxPrice.value,
          ),
          onChanged: c.onSlider,
        )),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Min Price"),
                  const SizedBox(height: 6),
                  TextField(
                    controller: c.minCtrl,
                    onSubmitted: (_) => c.onInputDone(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Max Price"),
                  const SizedBox(height: 6),
                  TextField(
                    controller: c.maxCtrl,
                    onSubmitted: (_) => c.onInputDone(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
