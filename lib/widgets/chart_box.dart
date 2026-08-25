import 'package:flutter/material.dart';

import '../models/sensor_history_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import 'chart_hint.dart';
import 'chart_legend.dart';
import 'sensor_trend_chart.dart';

class ChartBox extends StatelessWidget {
  final SensorHistoryModel? history;

  const ChartBox({
    super.key,
    required this.history,
  });

  Color getStatusColor(String status) {
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

  Color getStatusBackground(String status) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "GRAFIK TREN",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadius.large,
            boxShadow: AppShadows.soft,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: history == null
                ? const ChartHint()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Tren - ${history!.namaLokasi}",
                              style: const TextStyle(
                                fontSize: 17,
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
                              color: getStatusBackground(history!.status),
                              borderRadius: AppRadius.pill,
                            ),
                            child: Text(
                              history!.status,
                              style: TextStyle(
                                color: getStatusColor(history!.status),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      const ChartLegend(),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 240,
                        width: double.infinity,
                        child: SensorTrendChart(
                          history: history!.history,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}