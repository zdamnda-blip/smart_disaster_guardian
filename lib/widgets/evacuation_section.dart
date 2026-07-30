import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class EvacuationSection extends StatelessWidget {
  const EvacuationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "LANGKAH EVAKUASI",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadius.large,
            boxShadow: AppShadows.soft,
          ),
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              children: [

                _EvacuationStep(
                  number: 1,
                  text:
                      "Tetap tenang dan ikuti arahan dari perangkat desa atau petugas.",
                ),

                SizedBox(height: 18),

                _EvacuationStep(
                  number: 2,
                  text:
                      "Segera menuju titik kumpul atau lokasi evakuasi yang telah ditentukan.",
                ),

                SizedBox(height: 18),

                _EvacuationStep(
                  number: 3,
                  text:
                      "Bawa dokumen penting, obat-obatan, dan kebutuhan darurat seperlunya.",
                ),

              ],
            ),
          ),
        ),

      ],
    );
  }
}

class _EvacuationStep extends StatelessWidget {
  final int number;
  final String text;

  const _EvacuationStep({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "$number",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                height: 1.6,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),

      ],
    );
  }
}