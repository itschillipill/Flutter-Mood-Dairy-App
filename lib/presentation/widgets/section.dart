import 'package:flutter/material.dart';
import 'package:flutter_test_app/core/theme/app_pallet.dart';

class SectionWidget extends StatelessWidget {
  final List<Widget> children;
  final String label;
  const SectionWidget({super.key, required this.children, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: AppPallet.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            ...children
          ]),
    );
  }
}
