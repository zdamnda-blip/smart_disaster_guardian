import 'dart:async';

import 'package:flutter/material.dart';

import '../models/sensor_history_model.dart';
import '../models/sensor_model.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/app_banner.dart';
import '../widgets/chart_box.dart';
import '../widgets/map_area.dart';
import '../widgets/sensor_list.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<SensorModel> sensors = [];
  SensorHistoryModel? history;
  int? selectedSensorId;
  String? errorMessage;

  Timer? refreshTimer;

  @override
  void initState() {
    super.initState();

    loadSensors();

    refreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) {
        loadSensors();
      },
    );
  }

  Future<void> loadSensors() async {
    try {
      final data = await ApiService.getSensors();

      if (!mounted) return;

      setState(() {
        sensors = data;
        errorMessage = null;
      });

      if (selectedSensorId != null) {
        loadSensorHistory(selectedSensorId!);
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> loadSensorHistory(int sensorId) async {
    try {
      final data = await ApiService.getSensorHistory(sensorId);

      if (!mounted) return;

      setState(() {
        selectedSensorId = sensorId;
        history = data;
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (sensors.isEmpty && errorMessage == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 14,
                    color: Color(0x14000000),
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cloud_off_rounded,
                    size: 70,
                    color: Colors.red,
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Gagal Mengambil Data",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: loadSensors,
                      child: const Text(
                        "Coba Lagi",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: loadSensors,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBanner(
                  title: "Monitoring",
                  image: "assets/images/map_banner.jpeg",
                ),

                MapArea(
                  sensors: sensors,
                  selectedSensorId: selectedSensorId,
                  onMarkerTap: (sensor) {
                    loadSensorHistory(sensor.id);
                  },
                ),

                const SizedBox(height: 24),

                ChartBox(
                  history: history,
                ),

                const SizedBox(height: 24),

                SensorList(
                  sensors: sensors,
                  selectedSensorId: selectedSensorId,
                  onSensorTap: (sensor) {
                    loadSensorHistory(sensor.id);
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}