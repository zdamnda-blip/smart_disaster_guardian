
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class EmergencyDialog extends StatelessWidget {
  final VoidCallback onCall;

  const EmergencyDialog({
    super.key,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.large,
      ),
      title: const Row(
        children: [

          Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ),

          SizedBox(width: 10),

          Text(
            "Sebelum Menghubungi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _DialogItem(
            text: "Pastikan ini kondisi darurat sungguhan",
          ),

          SizedBox(height: 12),

          _DialogItem(
            text: "Siapkan informasi lokasi Anda",
          ),

          SizedBox(height: 12),

          _DialogItem(
            text: "Tetap tenang saat berbicara dengan petugas",
          ),

        ],
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [

        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.medium,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Batal"),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.medium,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            onCall();
          },
          child: const Text("Hubungi Sekarang"),
        ),

      ],
    );
  }
}

class _DialogItem extends StatelessWidget {
  final String text;

  const _DialogItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Icon(
          Icons.check_circle,
          color: AppColors.primary,
          size: 20,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ),

      ],
    );
  }
}