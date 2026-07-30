import 'package:flutter/material.dart';

import '../models/sensor_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class MapArea extends StatelessWidget {
  final List<SensorModel> sensors;
  final int? selectedSensorId;
  final Function(SensorModel) onMarkerTap;

  const MapArea({
    super.key,
    required this.sensors,
    required this.selectedSensorId,
    required this.onMarkerTap,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "PETA LOKASI SENSOR",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadius.large,
            boxShadow: AppShadows.soft,
          ),
          child: ClipRRect(
            borderRadius: AppRadius.large,
            child: Stack(
              children: [

                Container(
                  color: const Color(0xFFF3F5F4),
                ),

                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.map_outlined,
                        size: 52,
                        color: AppColors.primary,
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Google Maps / Flutter Map",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ],
                  ),
                ),

                if (sensors.isNotEmpty)
                  Positioned(
                    top: 40,
                    left: 80,
                    child: _buildMarker(sensors[0]),
                  ),

                if (sensors.length > 1)
                  Positioned(
                    top: 90,
                    right: 70,
                    child: _buildMarker(sensors[1]),
                  ),

                if (sensors.length > 2)
                  Positioned(
                    bottom: 45,
                    left: 150,
                    child: _buildMarker(sensors[2]),
                  ),

              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildMarker(SensorModel sensor) {
    final bool selected = selectedSensorId == sensor.id;

    return GestureDetector(
      onTap: () {
        onMarkerTap(sensor);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: selected ? 28 : 20,
        height: selected ? 28 : 20,
        decoration: BoxDecoration(
          color: getStatusColor(sensor.status),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          boxShadow: AppShadows.soft,
        ),
        child: selected
            ? const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 16,
              )
            : null,
      ),
    );
  }
}