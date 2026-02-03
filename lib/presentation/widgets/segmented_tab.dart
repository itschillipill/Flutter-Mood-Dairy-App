import 'package:flutter/material.dart';
import 'package:flutter_test_app/core/theme/app_pallet.dart';

class OverlaySegmentedTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const OverlaySegmentedTabs({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const _radius = 25.0;
  static const _duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_radius),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _BaseSegment(
                    color: AppPallet.grey,
                    text: 'Дневник настроения',
                    icon: Icons.book_outlined,
                    onTap: () => onTap(0),
                  ),
                  _BaseSegment(
                    color: AppPallet.grey,
                    text: 'Cтатистика',
                    icon: Icons.bar_chart_outlined,
                    onTap: () => onTap(1),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: _duration,
              curve: Curves.easeOut,
              left: selectedIndex == 0 ? 0 : null,
              right: selectedIndex == 1 ? 0 : null,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(_radius),
                color: AppPallet.orange,
                child: _ActiveSegment(
                  color: Colors.white,
                  text:
                      selectedIndex == 0 ? 'Дневник настроения' : 'Статистика',
                  icon: selectedIndex == 0 ? Icons.book_outlined : Icons.bar_chart_outlined,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BaseSegment extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _BaseSegment({
    required this.text,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          spacing: 4,
          children: [
            Icon(icon, color: color),
            Text(text, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}

class _ActiveSegment extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const _ActiveSegment({
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        spacing: 4,
        children: [
          Icon(icon, color: color),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
