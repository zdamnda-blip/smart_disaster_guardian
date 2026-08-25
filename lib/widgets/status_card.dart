import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';
import '../models/location_model.dart';
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
    if (dashboard.status.toLowerCase() == "aman" || dashboard.lokasiBerisiko.isEmpty) {
      return _buildAmanCard();
    }

    return SizedBox(
      height: 120, // Adjusted height for side-scrolling cards
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dashboard.lokasiBerisiko.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return _buildRiskCard(dashboard.lokasiBerisiko[index], dashboard.updateTerakhir);
        },
      ),
    );
  }

  Widget _buildAmanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.aman,
        borderRadius: AppRadius.large,
        boxShadow: AppShadows.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 8),
              const Text(
                "AMAN",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Semua titik sensor dalam kondisi aman",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, color: Colors.white, size: 14),
              const SizedBox(width: 6),
              Text(
                dashboard.updateTerakhir,
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard(LocationModel location, String updateTime) {
    Color cardColor = location.status.toLowerCase() == "bahaya" ? AppColors.siaga : AppColors.waspada;
    IconData iconData = location.status.toLowerCase() == "bahaya" ? Icons.warning_rounded : Icons.warning_amber_rounded;

    return Container(
      width: 200, // Fixed width for horizontal scrolling
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: AppRadius.large,
        boxShadow: AppShadows.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconData, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Text(
                location.status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_rounded, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Lokasi : ${location.namaLokasi}",
                  style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.2),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text(
                updateTime, // Or location-specific time if available
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}