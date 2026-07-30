import 'package:flutter/material.dart';

import '../models/history_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class HistoryCard extends StatelessWidget {
  final HistoryModel history;

  const HistoryCard({
    super.key,
    required this.history,
  });

  Color get statusColor {
    switch (history.status.toLowerCase()) {
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
    switch (history.status.toLowerCase()) {
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Expanded(
                  child: Text(
                    history.lokasi,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

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
                    history.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 10),

            Text(
              "${history.waktu} • ${history.deskripsi}",
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),

          ],
        ),
      ),
    );
  }
}