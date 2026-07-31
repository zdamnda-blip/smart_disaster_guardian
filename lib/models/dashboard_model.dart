import 'location_model.dart';

class DashboardModel {
  final String status;
  final String lokasi;
  final String rekomendasi;
  final String updateTerakhir;

  final double kelembabanTanah;
  final double curahHujan;

  final String pergerakanTanah;
  final String sensorAktif;

  final List<LocationModel> lokasiBerisiko;

  const DashboardModel({
    required this.status,
    required this.lokasi,
    required this.rekomendasi,
    required this.updateTerakhir,
    required this.kelembabanTanah,
    required this.curahHujan,
    required this.pergerakanTanah,
    required this.sensorAktif,
    required this.lokasiBerisiko,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      status: json["status"] ?? "",
      lokasi: json["lokasi"] ?? "",
      rekomendasi: json["rekomendasi"] ?? "",
      updateTerakhir: json["updateTerakhir"] ?? "",

      // Menggunakan (as num?)?.toDouble() agar fleksibel menerima int maupun double
      kelembabanTanah: (json["kelembabanTanah"] as num?)?.toDouble() ?? 0.0,
      curahHujan: (json["curahHujan"] as num?)?.toDouble() ?? 0.0,

      pergerakanTanah: json["pergerakanTanah"] ?? "",
      sensorAktif: json["sensorAktif"] ?? "",

      lokasiBerisiko: (json["lokasiBerisiko"] as List<dynamic>?)
              ?.map((item) => LocationModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}