class HistoryPointModel {
  final String time;

  final int kelembabanTanah;
  final int curahHujan;

  final bool pergerakanTanah;

  const HistoryPointModel({
    required this.time,
    required this.kelembabanTanah,
    required this.curahHujan,
    required this.pergerakanTanah,
  });

  factory HistoryPointModel.fromJson(Map<String, dynamic> json) {
    return HistoryPointModel(
      time: json["time"],
      kelembabanTanah: json["kelembabanTanah"],
      curahHujan: json["curahHujan"],
      pergerakanTanah: json["pergerakanTanah"],
    );
  }
}