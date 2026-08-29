// TODO: HAPUS FILE INI SAAT BACKEND SIAP

class DummyData {
  static List<Map<String, dynamic>> announcements = [
    {
      "id": 1,
      "text": "Telah terjadi longsor pada KM 8 yang mengakibatkan pohon tumbang menutupi jalan",
      "date": "2026-08-09 09:30:00",
      "isUrgent": true,
    },
    {
      "id": 2,
      "text": "Evakuasi darurat di jalur NUPA BOMBA KM 8 - Berlaku buka tutup jalan mulai pukul 10.00",
      "date": "2026-08-09 09:45:00",
      "isUrgent": false,
    },
  ];

  static List<Map<String, dynamic>> sensors = [
    {
      "id": 1,
      "name": "Sensor 1 - Nupa Bomaba KM 8",
      "latitude": -0.8,
      "longitude": 119.8,
      "isActive": true,
      "reason": null,
      "status": "Bahaya",
      "kelembabanTanah": 90.0,
      "curahHujan": 75.0,
      "pergerakanTanah": "Tidak Stabil",
    },
    {
      "id": 2,
      "name": "Sensor 2 - Wentira KM 23",
      "latitude": -0.9,
      "longitude": 119.9,
      "isActive": true,
      "reason": null,
      "status": "Waspada",
      "kelembabanTanah": 80.0,
      "curahHujan": 65.0,
      "pergerakanTanah": "Sedikit Bergeser",
    },
    {
      "id": 3,
      "name": "Sensor 3 - Toboli KM 34",
      "latitude": -1.0,
      "longitude": 120.0,
      "isActive": true,
      "reason": null,
      "status": "Aman",
      "kelembabanTanah": 20.0,
      "curahHujan": 25.0,
      "pergerakanTanah": "Stabil",
    },
  ];

  static List<Map<String, dynamic>> reports = [
    {
      "id": 1,
      "tingkatBahaya": "Tinggi",
      "waktu": "09-08-2026, 14.20",
      "deskripsi": "Suara gemuruh terdengar arah bukit, dan beberapa batu kecil berjatuhan",
      "lokasi": "Bukit Selatan KM 15 LS -0,0000000288197",
      "pelapor": "Apriansyah",
      "telepon": "0821-XXXX-XXXX",
      "status": "Baru", 
      "catatan": null,
    }
  ];

  static List<Map<String, dynamic>> warnings = [
    {
      "id": 1,
      "pesan": "Status BAHAYA terdeteksi di Nupa Bomaba KM 8. Pergerakan tanah tinggi.",
      "waktu": DateTime.now().subtract(const Duration(hours: 1)).toString(),
      "jenis": "Bahaya",
      "lokasi": "Nupa Bomaba KM 8",
    },
    {
      "id": 2,
      "pesan": "Status WASPADA terdeteksi di Wentira KM 23. Curah hujan meningkat.",
      "waktu": DateTime.now().subtract(const Duration(hours: 2)).toString(),
      "jenis": "Waspada",
      "lokasi": "Wentira KM 23",
    },
    {
      "id": 3,
      "pesan": "Status AMAN terdeteksi di Toboli KM 34. Hujan telah reda.",
      "waktu": DateTime.now().subtract(const Duration(hours: 3)).toString(),
      "jenis": "Aman",
      "lokasi": "Toboli KM 34",
    },
    {
      "id": 4,
      "pesan": "Status WASPADA terdeteksi di Nupa Bomaba KM 8. Hujan mulai turun.",
      "waktu": DateTime.now().subtract(const Duration(hours: 4)).toString(),
      "jenis": "Waspada",
      "lokasi": "Nupa Bomaba KM 8",
    },
  ];
}
