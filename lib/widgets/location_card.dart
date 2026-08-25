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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Pin icon lingkaran
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
                        lokasi.namaLokasi,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Kelembaban ${lokasi.kelembaban}% • Curah Hujan ${lokasi.curahHujan} mm",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
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

            const SizedBox(height: 14),

            // Progress bar (memakai data kelembaban)
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: lokasi.kelembaban / 100,
                      backgroundColor: Colors.grey.shade200,
                      color: statusColor,
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${lokasi.kelembaban}%",
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
              "Pergerakan Tanah : ${lokasi.pergerakanTanah}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}