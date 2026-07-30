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
          "Ringkasan Sensor",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 16),

        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.15,
          children: [
            SensorItem(
              title: "Kelembaban Tanah",
              value: "${dashboard.kelembabanTanah}%",
              icon: Icons.water_drop_outlined,
            ),
            SensorItem(
              title: "Curah Hujan",
              value: "${dashboard.curahHujan} mm",
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