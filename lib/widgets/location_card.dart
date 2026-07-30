import 'package:flutter/material.dart';

import '../models/location_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class LocationCard extends StatelessWidget {
  final LocationModel lokasi;

  const LocationCard({
    super.key,
    required this.lokasi,
  });

  Color get statusColor {
    switch (lokasi.status.toLowerCase()) {
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
    switch (lokasi.status.toLowerCase()) {
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
                    lokasi.namaLokasi,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
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
                    lokasi.status,
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
              "Status : ${lokasi.status}",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Kelembaban ${lokasi.kelembaban}% • Curah Hujan ${lokasi.curahHujan} mm",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "Pergerakan Tanah : ${lokasi.pergerakanTanah}",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),

          ],
        ),
      ),
    );
  }
}