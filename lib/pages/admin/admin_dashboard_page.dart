import 'package:flutter/material.dart';

import '../../services/dummy_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../home_page.dart';
import 'admin_announcement_page.dart';
import 'admin_report_page.dart';
import 'admin_sensor_page.dart';

// NEW: Admin Dashboard Page
class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  void _refreshData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int activeSensors = DummyData.sensors.where((s) => s['isActive'] == true).length;
    int totalSensors = DummyData.sensors.length;
    int newReports = DummyData.reports.where((r) => r['status'] == 'Baru').length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            icon: Icons.sensors,
                            title: "SENSOR AKTIF",
                            value: "$activeSensors/$totalSensors",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            icon: Icons.assignment,
                            title: "LAPORAN TERBARU",
                            value: "$newReports",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildMenuItem(
                      context,
                      icon: Icons.sensors,
                      title: "Kelola Sensor",
                      subtitle: "Aktifkan atau Nonaktifkan titik sensor",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AdminSensorPage()),
                        ).then((_) => _refreshData());
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      context,
                      icon: Icons.notifications_none,
                      title: "Kelola Pengumuman",
                      subtitle: "Tambah, ubah, atau hapus pengumuman",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AdminAnnouncementPage()),
                        ).then((_) => _refreshData());
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildMenuItem(
                      context,
                      icon: Icons.assignment_outlined,
                      title: "Kelola Laporan",
                      subtitle: "Tinjau dan kelola laporan yang masuk",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AdminReportPage()),
                        ).then((_) => _refreshData());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 240,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/dashboard_banner.jpeg"), // Using existing banner
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              // Removing the heavy gradient to make the image brighter, like the photo
            ),
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Stack(
                children: [
                  // Top Right Logout Button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 32),
                      onPressed: () {
                        // Logout back to User App
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                  
                  // Left side texts
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                        ),
                        child: const Text(
                          "HALAMAN ADMIN",
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "SIGAP",
                        style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: 2),
                      ),
                      const SizedBox(height: 30), // Spacing for the overlapping cards
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.large,
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.divider),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 20, color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppRadius.large,
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.keyboard_double_arrow_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

