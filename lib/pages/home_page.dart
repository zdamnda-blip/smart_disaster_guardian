import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'chatbot_page.dart';
import 'dashboard_page.dart';
import 'history_page.dart';
import 'map_page.dart';
import 'report_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  bool scrollMapToSensorList = false;

  void _goToMonitoring({bool scrollToSensorList = false}) {
    setState(() {
      currentIndex = 1;
      scrollMapToSensorList = scrollToSensorList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(
        onLihatSelengkapnya: () {
          _goToMonitoring(scrollToSensorList: true);
        },
      ),
      MapPage(
        scrollToSensorList: scrollMapToSensorList,
      ),
      const HistoryPage(),
      const ReportPage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatbotPage()));
        },
        backgroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.smart_toy, color: AppColors.primary),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        backgroundColor: Colors.white,
        indicatorColor: AppColors.accent,
        height: 72,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            selectedIcon: Icon(Icons.grid_view_rounded, color: AppColors.primary),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map, color: AppColors.primary),
            label: "Monitoring",
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline_rounded),
            selectedIcon: Icon(Icons.info_rounded, color: AppColors.primary),
            label: "Informasi",
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment, color: AppColors.primary),
            label: "Laporan",
          ),
        ],
      ),
    );
  }
}