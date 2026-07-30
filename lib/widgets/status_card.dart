import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class StatusCard extends StatelessWidget {
  final DashboardModel dashboard;

  const StatusCard({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    Color badgeBackground;

    switch (dashboard.status.toLowerCase()) {
      case "aman":
        badgeColor = AppColors.aman;
        badgeBackground = AppColors.amanBackground;
        break;

      case "waspada":
        badgeColor = AppColors.waspada;
        badgeBackground = AppColors.waspadaBackground;
        break;

      default:
        badgeColor = AppColors.siaga;
        badgeBackground = AppColors.siagaBackground;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.large,
        boxShadow: AppShadows.medium,
      ),
      child: Stack(
        children: [

          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.18,
              child: Image.asset(
                "assets/images/mountain.jpeg",
                width: 130,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Status",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBackground,
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    dashboard.status,
                    style: TextStyle(
                      color: badgeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [

                    const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: Text(
                        dashboard.lokasi,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                const Text(
                  "Rekomendasi",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  dashboard.rekomendasi,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 18),

                Divider(
                  color: AppColors.divider,
                ),

                const SizedBox(height: 12),

                Row(
                  children: [

                    const Icon(
                      Icons.access_time_filled_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        dashboard.updateTerakhir,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}