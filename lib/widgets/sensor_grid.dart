import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';
import '../theme/app_colors.dart';
import 'sensor_item.dart';

class SensorGrid extends StatelessWidget {
  final DashboardModel dashboard;

  const SensorGrid({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "RINGKASAN NILAI RATA-RATA SENSOR",
          style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 16),

        GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.85,
          children: [
            SensorItem(
              title: "Kelembaban Tanah",
              value: "${dashboard.kelembabanTanah.toInt()}%",
              icon: Icons.water_drop_outlined,
            ),
            SensorItem(
              title: "Curah Hujan",
              value: "${dashboard.curahHujan.toInt()} mm",
              icon: Icons.cloud_outlined,
            ),
            SensorItem(
              title: "Pergerakan Tanah",
              value: dashboard.pergerakanTanah,
              icon: Icons.show_chart,
            ),
            SensorItem(
              title: "Sensor Aktif",
              value: dashboard.sensorAktif,
              icon: Icons.sensors_outlined,
            ),
          ],
        ),
      ],
    );
  }
}