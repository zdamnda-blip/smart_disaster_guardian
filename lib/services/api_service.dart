import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/dashboard_model.dart';
import '../models/history_model.dart';
import '../models/history_point_model.dart';
import '../models/sensor_history_model.dart';
import '../models/sensor_model.dart';
import '../models/location_model.dart';
import 'dummy_data.dart';

class ApiService {
  static const String baseUrl = "https://undusted-vagrantly-fountain.ngrok-free.dev";

  static Map<String, String> get headers => {
        "Content-Type": "application/json",
        "ngrok-skip-browser-warning": "69420",
      };

  /// ===========================
  /// DASHBOARD (MOBILE)
  /// ===========================

  static Future<DashboardModel> getDashboard() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    
    // Calculate averages
    final sensors = DummyData.sensors;
    int activeSensors = sensors.where((s) => s['isActive'] == true).length;
    
    double avgKelembaban = sensors.fold(0.0, (sum, s) => sum + (s['kelembabanTanah'] as double)) / sensors.length;
    double avgCurahHujan = sensors.fold(0.0, (sum, s) => sum + (s['curahHujan'] as double)) / sensors.length;
    bool adaPergerakan = sensors.any((s) => s['pergerakanTanah'] != 'Stabil');

    List<LocationModel> berisiko = sensors
        .where((s) => s['status'].toLowerCase() != 'aman')
        .map<LocationModel>((s) => LocationModel(
              namaLokasi: s['name'].toString().split(' - ').last,
              status: s['status'],
              kelembaban: (s['kelembabanTanah'] as num).toDouble(),
              curahHujan: (s['curahHujan'] as num).toDouble(),
              pergerakanTanah: s['pergerakanTanah'].toString(),
            ))
        .toList();

    String topStatus = "Aman";
    if (berisiko.any((s) => s.status.toLowerCase() == 'bahaya')) {
      topStatus = "Bahaya";
    } else if (berisiko.any((s) => s.status.toLowerCase() == 'waspada')) {
      topStatus = "Waspada";
    }
    
    return DashboardModel(
      status: topStatus,
      lokasi: "Sistem Pemantauan Terpadu",
      rekomendasi: topStatus == "Aman" ? "Semua sistem dalam kondisi aman. Tetap lakukan pemantauan rutin." : "Harap waspada, terdeteksi status berisiko.",
      updateTerakhir: "Baru saja",
      kelembabanTanah: avgKelembaban,
      curahHujan: avgCurahHujan,
      pergerakanTanah: adaPergerakan ? "Terdeteksi" : "Stabil",
      sensorAktif: "$activeSensors/${sensors.length}",
      lokasiBerisiko: berisiko,
    );
  }

  /// ===========================
  /// SENSOR 
  /// ===========================

  static Future<List<SensorModel>> getSensors() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // MOCK DATA:
    return DummyData.sensors.map((s) => SensorModel(
      id: s['id'],
      namaLokasi: s['name'],
      status: s['status'],
      kelembabanTanah: s['kelembabanTanah'],
      curahHujan: s['curahHujan'],
      pergerakanTanah: s['pergerakanTanah'],
    )).toList();
  }

  /// ===========================
  /// HISTORY SENSOR 
  /// ===========================

  static Future<SensorHistoryModel> getSensorHistory(
    int sensorId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // MOCK DATA:
    return SensorHistoryModel(
      id: sensorId,
      namaLokasi: "Sensor $sensorId",
      status: "Aman",
      history: const [
        HistoryPointModel(time: "10:00", kelembabanTanah: 20, curahHujan: 0, pergerakanTanah: "Stabil"),
        HistoryPointModel(time: "11:00", kelembabanTanah: 21, curahHujan: 5, pergerakanTanah: "Stabil"),
        HistoryPointModel(time: "12:00", kelembabanTanah: 22, curahHujan: 10, pergerakanTanah: "Stabil"),
      ],
    );
  }

  /// ===========================
  /// HISTORY PERINGATAN
  /// ===========================

  static Future<List<HistoryModel>> getHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // MOCK DATA LOGIC:
    var sortedWarnings = List<Map<String, dynamic>>.from(DummyData.warnings);
    sortedWarnings.sort((a, b) => DateTime.parse(b['waktu']).compareTo(DateTime.parse(a['waktu'])));
    
    if (sortedWarnings.isEmpty) return [];

    DateTime latestTime = DateTime.parse(sortedWarnings.first['waktu']);
    if (DateTime.now().difference(latestTime).inHours >= 10) {
      return []; // Return empty so UI shows "tidak ada Riwayat terbaru"
    }

    return sortedWarnings.take(3).map((w) => HistoryModel(
      id: w['id'],
      lokasi: w['lokasi'],
      status: w['jenis'],
      deskripsi: w['pesan'],
      waktu: w['waktu'],
    )).toList();
  }
}
