import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const SmartDisasterGuardianApp());
}

class SmartDisasterGuardianApp extends StatelessWidget {
  const SmartDisasterGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Disaster Guardian',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        fontFamily: 'Poppins',
      ),

      home: const HomePage(),
    );
  }
}