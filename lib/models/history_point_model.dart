class HistoryPointModel {
  final String time;
  final double kelembabanTanah;
  final double curahHujan;
  final bool pergerakanTanah;

  const HistoryPointModel({
    required this.time,
    required this.kelembabanTanah,
    required this.curahHujan,
    required this.pergerakanTanah,
  });

  factory HistoryPointModel.fromJson(Map<String, dynamic> json) {
    return HistoryPointModel(
      time: json["time"] ?? "",
      // (as num?) aman menangani int maupun double dari JSON
      kelembabanTanah: (json["kelembabanTanah"] as num?)?.toDouble() ?? 0.0,
      curahHujan: (json["curahHujan"] as num?)?.toDouble() ?? 0.0,
      pergerakanTanah: json["pergerakanTanah"] ?? false,
    );
  }
}