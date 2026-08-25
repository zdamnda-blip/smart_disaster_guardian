import 'dart:async';

import 'package:flutter/material.dart';

import '../models/history_model.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/app_banner.dart';
import '../widgets/emergency_button.dart';
import '../widgets/evacuation_section.dart';
import '../widgets/history_list.dart';
import '../widgets/status_info_section.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryModel> histories = [];
  String? errorMessage;

  Timer? refreshTimer;

  @override
  void initState() {
    super.initState();

    loadHistory();

    refreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) {
        loadHistory();
      },
    );
  }

  Future<void> loadHistory() async {
    try {
      final data = await ApiService.getHistory();

      if (!mounted) return;

      setState(() {
        histories = data;
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
    if (histories.isEmpty && errorMessage == null) {
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
                      onPressed: loadHistory,
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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 30),
          onPressed: () {},
        ),
        title: const Text(
          "INFORMASI",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: loadHistory,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MODIFIED: Removed AppBanner
              HistoryList(
                histories: histories,
              ),

              const SizedBox(height: 24),

              const StatusInfoSection(),

              const SizedBox(height: 24),

              const EvacuationSection(),

              const SizedBox(height: 24),

              const EmergencyButton(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}