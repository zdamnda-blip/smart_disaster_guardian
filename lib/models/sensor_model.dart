class SensorModel {
  final int id;
  final String namaLokasi;
  final String status;

  final double kelembabanTanah;
  final double curahHujan; 

  final String pergerakanTanah;

  const SensorModel({
    required this.id,
    required this.namaLokasi,
    required this.status,
    required this.kelembabanTanah,
    required this.curahHujan,
    required this.pergerakanTanah,
  });

factory SensorModel.fromJson(Map<String, dynamic> json) {
  return SensorModel(
    id: json["id"] ?? 0,
    namaLokasi: json["namaLokasi"] ?? "",
    status: json["status"] ?? "",
    kelembabanTanah: (json["kelembabanTanah"] as num?)?.toDouble() ?? 0.0,
    curahHujan: (json["curahHujan"] as num?)?.toDouble() ?? 0.0,
    pergerakanTanah: json["pergerakanTanah"] ?? "",
  );
}
}