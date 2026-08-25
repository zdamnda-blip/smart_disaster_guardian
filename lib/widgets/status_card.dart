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
    IconData statusIcon;

    switch (dashboard.status.toLowerCase()) {
      case "aman":
        badgeColor = AppColors.aman;
        statusIcon = Icons.check_circle_rounded;
        break;

      case "waspada":
        badgeColor = AppColors.waspada;
        statusIcon = Icons.warning_rounded;
        break;

      default:
        badgeColor = AppColors.siaga;
        statusIcon = Icons.warning_rounded;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            badgeColor,
            badgeColor.withOpacity(0.75),
          ],
        ),
        borderRadius: AppRadius.large,
        boxShadow: AppShadows.medium,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Icon + Status besar
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    statusIcon,
                    color: Colors.white,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  dashboard.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Lokasi
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Lokasi: ${dashboard.lokasi}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Update terakhir
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Update Terakhir ${dashboard.updateTerakhir}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}