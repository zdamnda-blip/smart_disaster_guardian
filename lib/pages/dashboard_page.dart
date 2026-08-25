import 'dart:async';

import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/announcement_section.dart'; // NEW
import '../widgets/app_banner.dart';
import '../widgets/location_section.dart';
import '../widgets/sensor_grid.dart';
import '../widgets/status_card.dart';

class DashboardPage extends StatefulWidget {
  final VoidCallback? onLihatSelengkapnya;

  const DashboardPage({
    super.key,
    this.onLihatSelengkapnya,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  DashboardModel? dashboard;
  String? errorMessage;

  Timer? refreshTimer;

  @override
  void initState() {
    super.initState();

    loadDashboard();

    refreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) {
        loadDashboard();
      },
    );
  }

  Future<void> loadDashboard() async {

    try {

      final data = await ApiService.getDashboard();

      if (!mounted) return;

      setState(() {
        dashboard = data;
        errorMessage = null;
      });

    } catch (e) {

      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
      });

    }

  }

  @override
  void dispose() {
    refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (dashboard == null && errorMessage == null) {
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
                      onPressed: loadDashboard,
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
        onRefresh: loadDashboard,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const AppBanner(
                  title: "SIGAP", // MODIFIED: Changed to SIGAP
                  image: "assets/images/dashboard_banner.jpeg",
                  showLiveIndicator: true,
                ),

                Transform.translate(
                  offset: const Offset(0, -40),
                  child: StatusCard(
                    dashboard: dashboard!,
                  ),
                ),

                const SizedBox(height: 4),

                SensorGrid(
                  dashboard: dashboard!,
                ),

                const SizedBox(height: 24),
                
                const AnnouncementSection(), // NEW

                const SizedBox(height: 24),

                LocationSection(
                  dashboard: dashboard!,
                  onLihatSelengkapnya: widget.onLihatSelengkapnya,
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