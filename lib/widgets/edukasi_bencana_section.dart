import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class EdukasiBencanaSection extends StatelessWidget {
  const EdukasiBencanaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.large,
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader("SEBELUM KEJADIAN"),
          _buildBulletItem("Cek status jalur/wilayah di aplikasi (aman/waspada/siaga)"),
          _buildBulletItem("Kenali titik aman/titik kumpul terdekat dari lokasi Anda"),
          
          const SizedBox(height: 12),
          _buildHeader("SAAT ADA PERINGATAN"),
          _buildBulletItem("Jika status naik ke SIAGA, segera menjauh,jangan menunggu longsor benar-benar terjadi"),
          _buildBulletItem("Jangan berada/berhenti di bawah tebing atau pinggir jurang saat hujan deras"),
          _buildBulletItem("Ikuti arahan petugas jika ada"),

          const SizedBox(height: 12),
          _buildHeader("SAAT LONGSOR TERJADI"),
          _buildBulletItem("Jangan menerobos material longsor"),
          _buildBulletItem("Tinggalkan kendaraan/rumah jika diinstruksikan, bawa barang penting saja"),
          _buildBulletItem("Jika dalam kondisi darurat,hubungi nomor darurat via aplikasi + bagikan lokasi GPS"),
          _buildBulletItem("Menuju titik kumpul/evakuasi terdekat"),

          const SizedBox(height: 12),
          _buildHeader("SETELAH KEJADIAN"),
          _buildBulletItem("Tunggu status aman resmi sebelum kembali"),
          _buildBulletItem("Lapor kondisi diri lewat aplikasi"),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0C5A37), // Dark green color from the image
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.circle, size: 6, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

