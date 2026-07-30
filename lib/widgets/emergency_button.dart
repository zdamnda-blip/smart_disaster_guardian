import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import 'emergency_dialog.dart';

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({super.key});

  static const String emergencyNumber = "082192981471";

  Future<void> callEmergency() async {
    final Uri phone = Uri(
      scheme: "tel",
      path: emergencyNumber,
    );

    if (await canLaunchUrl(phone)) {
      await launchUrl(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppRadius.large,
        boxShadow: AppShadows.soft,
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.large,
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => EmergencyDialog(
              onCall: callEmergency,
            ),
          );
        },
        icon: const Icon(
          Icons.call_rounded,
          size: 22,
        ),
        label: const Text(
          "Hubungi Kontak Darurat",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}