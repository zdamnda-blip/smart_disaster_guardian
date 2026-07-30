class HistoryModel {
  final int id;
  final String lokasi;
  final String status;
  final String deskripsi;
  final String waktu;

  const HistoryModel({
    required this.id,
    required this.lokasi,
    required this.status,
    required this.deskripsi,
    required this.waktu,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json["id"],
      lokasi: json["lokasi"],
      status: json["status"],
      deskripsi: json["deskripsi"],
      waktu: json["waktu"],
    );
  }
}