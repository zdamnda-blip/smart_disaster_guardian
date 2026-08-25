import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'dashboard_page.dart';
import 'history_page.dart';
import 'map_page.dart';

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
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
      ),
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
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: "Monitoring",
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outlined),
            selectedIcon: Icon(Icons.info),
            label: "Informasi",
          ),
        ],
      ),
    );
  }
}