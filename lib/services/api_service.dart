import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/dashboard_model.dart';
import '../models/history_model.dart';
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
    final response = await http.get(
  Uri.parse("$baseUrl/dashboard"),
  headers: headers,
);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return DashboardModel.fromJson(json);
    } else {
      throw Exception("Gagal mengambil data dashboard");
    }
  }

  /// ===========================
  /// SENSOR
  /// ===========================

  static Future<List<SensorModel>> getSensors() async {
    final response = await http.get(
  Uri.parse("$baseUrl/sensors"),
  headers: headers,
);

    if (response.statusCode == 200) {
      final List json = jsonDecode(response.body);

      return json
          .map((item) => SensorModel.fromJson(item))
          .toList();
    } else {
      throw Exception("Gagal mengambil data sensor");
    }
  }

  /// ===========================
  /// HISTORY SENSOR
  /// ===========================

  static Future<SensorHistoryModel> getSensorHistory(
    int sensorId,
  ) async {
    final response = await http.get(
  Uri.parse("$baseUrl/sensors/$sensorId/history"),
  headers: headers,
);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return SensorHistoryModel.fromJson(json);
    } else {
      throw Exception("Gagal mengambil riwayat sensor");
    }
  }

  /// ===========================
  /// HISTORY PERINGATAN
  /// ===========================

  static Future<List<HistoryModel>> getHistory() async {
    final response = await http.get(
  Uri.parse("$baseUrl/history"),
  headers: headers,
);

    if (response.statusCode == 200) {
      final List json = jsonDecode(response.body);

      return json
          .map((item) => HistoryModel.fromJson(item))
          .toList();
    } else {
      throw Exception("Gagal mengambil riwayat peringatan");
    }
  }
}