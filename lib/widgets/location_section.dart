import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';
import '../theme/app_colors.dart';
import 'location_card.dart';

class LocationSection extends StatelessWidget {
  final DashboardModel dashboard;
  final VoidCallback? onLihatSelengkapnya;

  const LocationSection({
    super.key,
    required this.dashboard,
    this.onLihatSelengkapnya,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "LOKASI BERISIKO",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                letterSpacing: 1,
              ),
            ),

            GestureDetector(
              onTap: onLihatSelengkapnya,
              child: const Text(
                "Lihat Selengkapnya",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        if (dashboard.lokasiBerisiko.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Center(
              child: Text(
                "Tidak ada lokasi berisiko saat ini",
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dashboard.lokasiBerisiko.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return LocationCard(
                lokasi: dashboard.lokasiBerisiko[index],
              );
            },
          ),
      ],
    );
  }
}