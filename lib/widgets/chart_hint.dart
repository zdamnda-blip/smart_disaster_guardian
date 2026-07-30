import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class ChartHint extends StatelessWidget {
  const ChartHint({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 28,
          ),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: AppRadius.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [

              Icon(
                Icons.touch_app_rounded,
                size: 54,
                color: AppColors.primary,
              ),

              SizedBox(height: 18),

              Text(
                "Pilih salah satu sensor",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "untuk melihat grafik tren",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}