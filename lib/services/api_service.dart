import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/dashboard_model.dart';
import '../models/history_model.dart';
import '../models/history_point_model.dart';
import '../models/sensor_history_model.dart';
import '../models/sensor_model.dart';

class ApiService {
  static const String baseUrl =
    "https://undusted-vagrantly-fountain.ngrok-free.dev";

     static const Map<String, String> headers = {
    "ngrok-skip-browser-warning": "true",
    "Accept": "application/json",
  };
  /// ===========================
  /// DASHBOARD 
  /// ===========================

  static Future<DashboardModel> getDashboard() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    
    // MOCK DATA:
    return const DashboardModel(
      status: "Aman",
      lokasi: "Nupa Bomaba KM 8",
      rekomendasi: "Semua sistem dalam kondisi aman. Tetap lakukan pemantauan rutin.",
      updateTerakhir: "Baru saja",
      kelembabanTanah: 25.5,
      curahHujan: 12.0,
      pergerakanTanah: "Stabil",
      sensorAktif: "3/3",
      lokasiBerisiko: [],
    );
  }

  /// ===========================
  /// SENSOR 
  /// ===========================

  static Future<List<SensorModel>> getSensors() async {
    await Future.delayed(const Duration(seconds: 1));
    
    // MOCK DATA:
    return [
      const SensorModel(id: 1, namaLokasi: "Sensor 1 - Nupa Bomaba KM 8", status: "Aman", kelembabanTanah: 20, curahHujan: 5, pergerakanTanah: "Stabil"),
      const SensorModel(id: 2, namaLokasi: "Sensor 2 - Wentira KM 23", status: "Aman", kelembabanTanah: 22, curahHujan: 10, pergerakanTanah: "Stabil"),
      const SensorModel(id: 3, namaLokasi: "Sensor 3 - Toboli KM 34", status: "Aman", kelembabanTanah: 25, curahHujan: 0, pergerakanTanah: "Stabil"),
    ];
  }

  /// ===========================
  /// HISTORY SENSOR 
  /// ===========================

  static Future<SensorHistoryModel> getSensorHistory(
    int sensorId,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    
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
    await Future.delayed(const Duration(seconds: 1));
    
    // MOCK DATA:
    return [
      const HistoryModel(
        id: 1,
        lokasi: "Nupa Bomaba KM 8",
        status: "Bahaya",
        deskripsi: "Pergerakan tanah tinggi.",
        waktu: "2026-08-08 14:00:00",
      ),
      const HistoryModel(
        id: 2,
        lokasi: "Wentira KM 23",
        status: "Waspada",
        deskripsi: "Curah hujan meningkat.",
        waktu: "2026-08-07 09:15:00",
      ),
    ];
  }
}

