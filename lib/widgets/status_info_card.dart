import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class StatusInfoCard extends StatelessWidget {
  final String status;
  final String deskripsi;

  const StatusInfoCard({
    super.key,
    required this.status,
    required this.deskripsi,
  });

  Color get statusColor {
    switch (status.toLowerCase()) {
      case "aman":
        return AppColors.aman;

      case "waspada":
        return AppColors.waspada;

      case "siaga":
      case "bahaya":
        return AppColors.siaga;

      default:
        return AppColors.textSecondary;
    }
  }

  Color get statusBackground {
    switch (status.toLowerCase()) {
      case "aman":
        return AppColors.amanBackground;

      case "waspada":
        return AppColors.waspadaBackground;

      case "siaga":
      case "bahaya":
        return AppColors.siagaBackground;

      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.large,
        boxShadow: AppShadows.soft,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: statusBackground,
                borderRadius: AppRadius.pill,
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                deskripsi,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}