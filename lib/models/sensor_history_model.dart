import 'history_point_model.dart';

class SensorHistoryModel {
  final int id;
  final String namaLokasi;
  final String status;
  final List<HistoryPointModel> history;

  const SensorHistoryModel({
    required this.id,
    required this.namaLokasi,
    required this.status,
    required this.history,
  });

factory SensorHistoryModel.fromJson(Map<String, dynamic> json) {
    return SensorHistoryModel(
      id: json["id"] ?? 0,
      namaLokasi: json["namaLokasi"] ?? "",
      status: json["status"] ?? "",
      history: (json["history"] as List<dynamic>?)
              ?.map((item) => HistoryPointModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}
