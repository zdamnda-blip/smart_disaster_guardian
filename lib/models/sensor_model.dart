class SensorModel {
  final int id;
  final String namaLokasi;
  final String status;

  final int kelembabanTanah;
  final int curahHujan;

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
      id: json["id"],
      namaLokasi: json["namaLokasi"],
      status: json["status"],
      kelembabanTanah: json["kelembabanTanah"],
      curahHujan: json["curahHujan"],
      pergerakanTanah: json["pergerakanTanah"],
    );
  }
}