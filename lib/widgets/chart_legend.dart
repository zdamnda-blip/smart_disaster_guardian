import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ChartLegend extends StatelessWidget {
  const ChartLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: const [

        _LegendItem(
          color: Colors.blue,
          label: "Kelembaban (%)",
        ),

        _LegendItem(
          color: Colors.teal,
          label: "Curah Hujan (mm)",
        ),

        _LegendTriangle(
          label: "Pergerakan Terdeteksi",
        ),

      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 8),

        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),

      ],
    );
  }
}

class _LegendTriangle extends StatelessWidget {
  final String label;

  const _LegendTriangle({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        const Icon(
          Icons.change_history,
          color: AppColors.siaga,
          size: 18,
        ),

        const SizedBox(width: 8),

        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),

      ],
    );
  }
}