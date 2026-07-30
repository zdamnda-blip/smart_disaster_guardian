import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'status_info_card.dart';

class StatusInfoSection extends StatelessWidget {
  const StatusInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "KETERANGAN STATUS",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 12),

        const StatusInfoCard(
          status: "Aman",
          deskripsi:
              "Kelembaban tanah ≤65% dan curah hujan ≤25 mm",
        ),

        const SizedBox(height: 12),

        const StatusInfoCard(
          status: "Waspada",
          deskripsi:
              "Kelembaban tanah >65% atau curah hujan >25 mm",
        ),

        const SizedBox(height: 12),

        const StatusInfoCard(
          status: "Bahaya",
          deskripsi:
              "Kelembaban tanah >80% atau curah hujan >45 mm",
        ),

      ],
    );
  }
}