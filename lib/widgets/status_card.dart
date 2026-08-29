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
    if (dashboard.lokasiBerisiko.isEmpty) {
      return _buildAmanCard();
    }

    final bahayaSensors = dashboard.lokasiBerisiko.where((s) => s.status.toLowerCase() == "bahaya").toList();
    final waspadaSensors = dashboard.lokasiBerisiko.where((s) => s.status.toLowerCase() == "waspada").toList();
    
    List<Widget> cards = [];
    if (bahayaSensors.isNotEmpty) {
      String names = bahayaSensors.map((s) => s.namaLokasi.split(' - ').last).join(', ');
      cards.add(_buildRiskCard("Bahaya", names, dashboard.updateTerakhir));
    }
    if (waspadaSensors.isNotEmpty) {
      String names = waspadaSensors.map((s) => s.namaLokasi.split(' - ').last).join(', ');
      cards.add(_buildRiskCard("Waspada", names, dashboard.updateTerakhir));
    }

    // Fallback just in case, though it shouldn't be reached if isEmpty is handled above
    if (cards.isEmpty) return _buildAmanCard(); 

    return SizedBox(
      height: 140, // Increased height slightly to fit 2 lines of location if split
      child: cards.length == 1
          ? SizedBox(
              width: double.infinity,
              child: _buildRiskCard(
                  bahayaSensors.isNotEmpty ? "Bahaya" : "Waspada", 
                  bahayaSensors.isNotEmpty 
                      ? bahayaSensors.map((s) => s.namaLokasi.split(' - ').last).join(', ')
                      : waspadaSensors.map((s) => s.namaLokasi.split(' - ').last).join(', '), 
                  dashboard.updateTerakhir,
                  isExpanded: true),
            )
          : Row(
              children: [
                Expanded(child: cards[0]),
                const SizedBox(width: 12),
                Expanded(child: cards[1]),
              ],
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

  Widget _buildRiskCard(String status, String locationNames, String updateTime, {bool isExpanded = false}) {
    Color cardColor = status.toLowerCase() == "bahaya" ? AppColors.siaga : AppColors.waspada;
    IconData iconData = status.toLowerCase() == "bahaya" ? Icons.warning_rounded : Icons.warning_amber_rounded;

    return Container(
      width: isExpanded ? double.infinity : null, // Take full width if expanded, else use flexible space in Row
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
              Expanded(
                child: Text(
                  status.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Adjusted slightly to fit in side-by-side
                    letterSpacing: 1,
                  ),
                  overflow: TextOverflow.ellipsis,
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
                  "Lokasi : $locationNames",
                  style: const TextStyle(color: Colors.white, fontSize: 11, height: 1.2), // Smaller text to fit side-by-side
                  maxLines: 3, // Allowed 3 lines for narrow cards
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(), // Push time to bottom
          Row(
            children: [
              const Icon(Icons.access_time_rounded, color: Colors.white, size: 12), // Smaller time icon
              const SizedBox(width: 4),
              Text(
                updateTime, // Or location-specific time if available
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}