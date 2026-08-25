import 'package:flutter/material.dart';

import '../models/sensor_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class SensorCard extends StatelessWidget {
  final SensorModel sensor;
  final bool isSelected;
  final VoidCallback onTap;

  const SensorCard({
    super.key,
    required this.sensor,
    required this.isSelected,
    required this.onTap,
  });

  Color get statusColor {
    switch (sensor.status.toLowerCase()) {
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
    switch (sensor.status.toLowerCase()) {
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
        color: isSelected
            ? AppColors.accent
            : Colors.white,
        borderRadius: AppRadius.large,
        boxShadow: AppShadows.soft,
        border: Border.all(
          color: isSelected
              ? statusColor
              : Colors.transparent,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.large,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // Icon lingkaran
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: statusBackground,
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: statusColor,
                        size: 20,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sensor ${sensor.id} - ${sensor.namaLokasi}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Kelembaban ${sensor.kelembabanTanah}% • Hujan ${sensor.curahHujan} mm",
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

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
                        sensor.status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 14),

                // Progress bar (memakai data kelembabanTanah)
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: sensor.kelembabanTanah / 100,
                          backgroundColor: Colors.grey.shade200,
                          color: statusColor,
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${sensor.kelembabanTanah}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  "Gerakan: ${sensor.pergerakanTanah}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}