import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _namaController = TextEditingController();
  final _teleponController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _waktuController = TextEditingController();
  final _deskripsiController = TextEditingController();

  String _tingkatBahaya = 'Tinggi';

  @override
  void dispose() {
    _namaController.dispose();
    _teleponController.dispose();
    _lokasiController.dispose();
    _waktuController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _kirimLaporan() {
    if (_formKey.currentState!.validate()) {
      // Mock logic to send report
      
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: AppRadius.large),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline, color: AppColors.primary, size: 48),
                const SizedBox(height: 16),
                const Text("Laporan Terkirim", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          );
        },
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 30),
          onPressed: () {},
        ),
        title: const Text(
          'LAPORAN', 
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.medium,
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: const Text(
                      "Laporkan kondisi atau kejadian di sekitarmu",
                      style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.large,
                boxShadow: AppShadows.soft,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.assignment, color: AppColors.textPrimary, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          "FORMULIR LAPORAN",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    _buildLabel("Nama Pelapor"),
                    _buildTextField(_namaController, "Masukkan nama lengkap"),
                    const SizedBox(height: 16),
                    
                    _buildLabel("Nomor Telepon"),
                    _buildTextField(_teleponController, "Masukkan nomor telepon", keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabel("Lokasi Kejadian"),
                        const Text("Gunakan lokasi Anda", style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    _buildTextField(_lokasiController, "Masukkan lokasi kejadian"),
                    const SizedBox(height: 16),
                    
                    _buildLabel("Tingkat Bahaya / Urgensi"),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildUrgensiBtn("Tinggi", Colors.red),
                        _buildUrgensiBtn("Sedang", Colors.orange),
                        _buildUrgensiBtn("Rendah", Colors.green),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    _buildLabel("Waktu Kejadian"),
                    _buildTextField(_waktuController, "DD-MM-YYYY", suffixIcon: Icons.calendar_today),
                    const SizedBox(height: 16),
                    
                    _buildLabel("Deskripsi Laporan"),
                    _buildTextField(_deskripsiController, "Ketikkan laporan anda", maxLines: 3),
                    const SizedBox(height: 16),
                    
                    _buildLabel("Unggah Foto (opsional)"),
                    const SizedBox(height: 8),
                    
                    // TODO: Implement image_picker here
                    // Nanti kita gunakan package image_picker untuk mengambil foto
                    // dari kamera/galeri lalu dikirim ke API melalui MultipartRequest
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.divider),
                        borderRadius: AppRadius.medium,
                        color: AppColors.background,
                      ),
                      child: const Center(
                        child: Icon(Icons.add_photo_alternate_outlined, color: AppColors.textSecondary, size: 32),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _kirimLaporan,
                        child: const Text(
                          "Kirim Laporan",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1, TextInputType? keyboardType, IconData? suffixIcon}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: AppColors.textSecondary, size: 20) : null,
      ),
      validator: (value) => value == null || value.isEmpty ? 'Field ini wajib diisi' : null,
    );
  }

  Widget _buildUrgensiBtn(String text, Color color) {
    bool isSelected = _tingkatBahaya == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _tingkatBahaya = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? color : AppColors.divider),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? color : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

