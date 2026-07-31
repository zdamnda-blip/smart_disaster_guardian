class LocationModel {
  final String namaLokasi;
  final String status;
  final double kelembaban;
  final double curahHujan;
  final String pergerakanTanah;

  const LocationModel({
    required this.namaLokasi,
    required this.status,
    required this.kelembaban,
    required this.curahHujan,
    required this.pergerakanTanah,
  });

 factory LocationModel.fromJson(Map<String, dynamic> json) {
  return LocationModel(
    namaLokasi: json["namaLokasi"] ?? "",
    status: json["status"] ?? "",
    kelembaban: (json["kelembaban"] as num?)?.toDouble() ?? 0.0,
    curahHujan: (json["curahHujan"] as num?)?.toDouble() ?? 0.0,
    pergerakanTanah: json["pergerakanTanah"] ?? "",
  );
}
}