import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';

// NEW: Admin Report Page
class AdminReportPage extends StatefulWidget {
  const AdminReportPage({super.key});

  @override
  State<AdminReportPage> createState() => _AdminReportPageState();
}

class _AdminReportPageState extends State<AdminReportPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // TODO: HAPUS DUMMY DATA INI SAAT BACKEND SIAP
  final List<Map<String, dynamic>> _reports = [
    {
      "id": 1,
      "tingkatBahaya": "Tinggi",
      "waktu": "09-08-2026, 14.20",
      "deskripsi": "Suara gemuruh terdengar arah bukit, dan beberapa batu kecil berjatuhan",
      "lokasi": "Bukit Selatan KM 15 LS -0,0000000288197",
      "pelapor": "Apriansyah",
      "telepon": "0821-XXXX-XXXX",
      "status": "Baru", // Baru, Diproses, Selesai, Arsip
      "catatan": null,
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getReportsByStatus(String status) {
    return _reports.where((r) => r['status'] == status).toList();
  }

  void _tandaiDiproses(int index, List<Map<String, dynamic>> filteredList) {
    final report = filteredList[index];
    setState(() {
      final realIndex = _reports.indexWhere((r) => r['id'] == report['id']);
      _reports[realIndex]['status'] = "Diproses";
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Tim telah dikerahkan untuk mengecek dan memantau lokasi")),
    );
  }

  void _tandaiSelesai(int index, List<Map<String, dynamic>> filteredList) {
    final report = filteredList[index];
    
    // Add logic to input catatan tindak lanjut
    final catatanController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.large),
          title: const Text("Tandai Selesai", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Catatan tindak lanjut", style: TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              TextField(
                controller: catatanController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Contoh: Tim telah mengecek...",
                  border: OutlineInputBorder(borderRadius: AppRadius.medium),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () {
                setState(() {
                  final realIndex = _reports.indexWhere((r) => r['id'] == report['id']);
                  _reports[realIndex]['status'] = "Selesai";
                  _reports[realIndex]['catatan'] = catatanController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Simpan & Selesai", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "KELOLA LAPORAN",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textSecondary,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.zero,
              tabs: [
                _buildTab("Baru (${_getReportsByStatus('Baru').length})"),
                _buildTab("Diproses(${_getReportsByStatus('Diproses').length})"),
                _buildTab("Selesai (${_getReportsByStatus('Selesai').length})"),
                _buildTab("Arsip"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildReportList("Baru"),
                _buildReportList("Diproses"),
                _buildReportList("Selesai"),
                _buildReportList("Arsip"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildReportList(String status) {
    final filteredReports = _getReportsByStatus(status);
    
    if (filteredReports.isEmpty) {
      return const Center(child: Text("Tidak ada laporan", style: TextStyle(color: AppColors.textSecondary)));
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredReports.length,
      itemBuilder: (context, index) {
        final report = filteredReports[index];
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadius.large,
            boxShadow: AppShadows.soft,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      report['tingkatBahaya'],
                      style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(report['waktu'], style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                ],
              ),
              const SizedBox(height: 12),
              Text(report['deskripsi'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(report['lokasi'], style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              const SizedBox(height: 12),
              const Divider(color: AppColors.divider),
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(report['pelapor'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(report['telepon'], style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
              if (report['catatan'] != null) ...[
                const SizedBox(height: 12),
                const Text("Catatan tindak lanjut", style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                Text(report['catatan'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
              
              if (status == "Baru") ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.divider),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => _tandaiDiproses(index, filteredReports),
                    child: const Text("Tandai Diproses"),
                  ),
                ),
              ] else if (status == "Diproses") ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.divider),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => _tandaiSelesai(index, filteredReports),
                    child: const Text("Tandai Selesai"),
                  ),
                ),
              ] else if (status == "Selesai") ...[
                const SizedBox(height: 16),
                const Center(
                  child: Text("Otomatis diarsipkan 30 hari setelah selesai", style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
