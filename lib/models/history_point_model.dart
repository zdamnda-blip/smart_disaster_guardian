class HistoryPointModel {
  final String time;
  final double kelembabanTanah;
  final double curahHujan;
  final String pergerakanTanah; 

  const HistoryPointModel({
    required this.time,
    required this.kelembabanTanah,
    required this.curahHujan,
    required this.pergerakanTanah,
  });

  factory HistoryPointModel.fromJson(Map<String, dynamic> json) {
    return HistoryPointModel(
      time: json["time"] ?? "",
      kelembabanTanah: (json["kelembabanTanah"] as num?)?.toDouble() ?? 0.0,
      curahHujan: (json["curahHujan"] as num?)?.toDouble() ?? 0.0,
      // .toString() memastikan apapun data yang masuk otomatis dikonversi ke String
      pergerakanTanah: json["pergerakanTanah"]?.toString() ?? "", 
    );
  }
}