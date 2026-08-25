import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';

// NEW: Admin Sensor Page
class AdminSensorPage extends StatefulWidget {
  const AdminSensorPage({super.key});

  @override
  State<AdminSensorPage> createState() => _AdminSensorPageState();
}

class _AdminSensorPageState extends State<AdminSensorPage> {
  // TODO: HAPUS DUMMY DATA INI SAAT BACKEND SIAP
  final List<Map<String, dynamic>> _sensors = [
    {
      "id": 1,
      "name": "Sensor 1 - Nupa Bomaba KM 8",
      "isActive": true,
      "reason": null,
    },
    {
      "id": 2,
      "name": "Sensor 2 - Wentira KM 23",
      "isActive": true,
      "reason": null,
    },
    {
      "id": 3,
      "name": "Sensor 3 - Toboli KM 34",
      "isActive": false,
      "reason": "Kerusakan kabel sensor, menunggu perbaikan",
    },
  ];

  void _toggleSensor(int index, bool currentValue) {
    if (currentValue) {
      // Disabling sensor -> show dialog
      _showDisableDialog(index);
    } else {
      // Enabling sensor -> just enable
      setState(() {
        _sensors[index]['isActive'] = true;
        _sensors[index]['reason'] = null;
      });
    }
  }

  void _showDisableDialog(int index) {
    final reasonController = TextEditingController();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.large),
          title: Text("Nonaktifkan ${_sensors[index]['name'].split('-')[0].trim()}?", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Sensor ini tidak akan mengirim data atau peringatan sampai diaktifkan kembali", style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              const Text("Alasan (wajib diisi)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Value",
                  hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(borderRadius: AppRadius.medium),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      if (reasonController.text.trim().isEmpty) return; // Prevent empty
                      
                      setState(() {
                        _sensors[index]['isActive'] = false;
                        _sensors[index]['reason'] = reasonController.text;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Nonaktifkan"),
                  ),
                ),
              ],
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
          "KELOLA SENSOR",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _sensors.length,
        itemBuilder: (context, index) {
          final sensor = _sensors[index];
          final isActive = sensor['isActive'] as bool;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
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
                    Expanded(
                      child: Text(
                        sensor['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Switch(
                      value: isActive,
                      activeColor: AppColors.primary,
                      onChanged: (val) => _toggleSensor(index, isActive),
                    ),
                  ],
                ),
                Text(
                  isActive ? "Aktif" : "Non-Aktif",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isActive ? AppColors.primary : Colors.red,
                  ),
                ),
                if (!isActive && sensor['reason'] != null) ...[
                  const SizedBox(height: 12),
                  const Text("Alasan non-Aktif", style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                  Text(sensor['reason'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
