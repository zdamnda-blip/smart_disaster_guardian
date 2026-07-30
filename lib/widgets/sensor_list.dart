import 'package:flutter/material.dart';

import '../models/sensor_model.dart';
import '../theme/app_colors.dart';
import 'sensor_card.dart';

class SensorList extends StatelessWidget {
  final List<SensorModel> sensors;
  final int? selectedSensorId;
  final Function(SensorModel) onSensorTap;

  const SensorList({
    super.key,
    required this.sensors,
    required this.selectedSensorId,
    required this.onSensorTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "DAFTAR SENSOR",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 12),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sensors.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: 12),
          itemBuilder: (context, index) {

            final sensor = sensors[index];

            return SensorCard(
              sensor: sensor,
              isSelected: selectedSensorId == sensor.id,
              onTap: () {
                onSensorTap(sensor);
              },
            );
          },
        ),

      ],
    );
  }
}