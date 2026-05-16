import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../controller/pricing_controller.dart';

class PriceRangeWidget extends StatelessWidget {
  final String tag;

  const PriceRangeWidget({super.key, required this.tag});

  PriceRangeController get c => Get.find<PriceRangeController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.primary.withOpacity(0.2),
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withOpacity(0.1),
              rangeThumbShape: _WhiteCenterThumb(),
            ),
            child: RangeSlider(
              min: c.minLimit,
              max: c.maxLimit,
              divisions: 100,
              values: RangeValues(c.minPrice.value, c.maxPrice.value),
              onChanged: c.onSlider,
            ),
          ),
        ),

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

class _WhiteCenterThumb extends RangeSliderThumbShape {
  const _WhiteCenterThumb();

  static const double _thumbRadius = 12;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(_thumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr, 
    Thumb thumb = Thumb.start,
  }) {
    final canvas = context.canvas;

    canvas.drawCircle(
      center,
      _thumbRadius,
      Paint()..color = sliderTheme.thumbColor ?? Colors.blue,
    );

    canvas.drawCircle(
      center,
      _thumbRadius * 0.5,
      Paint()..color = Colors.white,
    );
  }
}
