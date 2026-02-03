import 'package:flutter/material.dart';
import 'package:flutter_test_app/core/theme/app_pallet.dart';

class LabeledDiscreteSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final String leftLabel;
  final String rightLabel;

  const LabeledDiscreteSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.leftLabel,
    required this.rightLabel,
  });

  static const int divisionsCount = 6;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 8,
          child: Row(
            children: List.generate(divisionsCount, (index) {
              return Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 2,
                    height: 10,
                    decoration: BoxDecoration(
                      color:
                          index <= value ? AppPallet.orange : AppPallet.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            tickMarkShape: SliderTickMarkShape.noTickMark,
          ),
          child: Slider.adaptive(
            activeColor: AppPallet.orange,
            divisions: divisionsCount - 1,
            min: 0,
            max: (divisionsCount - 1).toDouble(),
            value: value,
            onChanged: onChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftLabel,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              rightLabel,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}