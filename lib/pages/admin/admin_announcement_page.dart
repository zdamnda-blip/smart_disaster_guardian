import 'package:flutter/material.dart';

import '../../services/dummy_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';

class AdminAnnouncementPage extends StatefulWidget {
  const AdminAnnouncementPage({super.key});

  @override
  State<AdminAnnouncementPage> createState() => _AdminAnnouncementPageState();
}

class _AdminAnnouncementPageState extends State<AdminAnnouncementPage> {
  // Use data from DummyData
  List<Map<String, dynamic>> get _announcements => DummyData.announcements;

  void _showAddDialog({Map<String, dynamic>? existingItem}) {
    final textController = TextEditingController(text: existingItem?['text'] ?? '');
    
    DateTime? selectedDate = existingItem != null 
        ? DateTime.tryParse(existingItem['date'].toString().replaceAll(" ", "T")) 
        : null;
        
    final dateController = TextEditingController(
      text: selectedDate != null 
          ? "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}"
          : '',
    );
    bool isUrgent = existingItem?['isUrgent'] ?? false;
    String errorMsg = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: AppRadius.large),
              title: Text(existingItem == null ? "Tambah Pengumuman" : "Edit Pengumuman", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Isi pengumuman", style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: textController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Masukkan isi pengumuman",
                        border: OutlineInputBorder(borderRadius: AppRadius.medium),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Waktu/Tanggal", style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: dateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Pilih tanggal",
                              suffixIcon: const Icon(Icons.calendar_today, size: 20),
                              border: OutlineInputBorder(borderRadius: AppRadius.medium),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate ?? DateTime.now(),
                                firstDate: DateTime.now(), // Prevent past dates
                                lastDate: DateTime(2030),
                              );
                              
                              if (pickedDate != null) {
                                setStateDialog(() {
                                  selectedDate = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    selectedDate?.hour ?? TimeOfDay.now().hour,
                                    selectedDate?.minute ?? TimeOfDay.now().minute,
                                  );
                                  dateController.text = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
                                  errorMsg = '';
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(
                              text: selectedDate != null 
                                ? "${selectedDate!.hour.toString().padLeft(2, '0')}:${selectedDate!.minute.toString().padLeft(2, '0')}"
                                : '',
                            ),
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Pilih waktu",
                              suffixIcon: const Icon(Icons.access_time, size: 20),
                              border: OutlineInputBorder(borderRadius: AppRadius.medium),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            onTap: () async {
                              if (selectedDate == null) {
                                setStateDialog(() => errorMsg = "Pilih tanggal terlebih dahulu");
                                return;
                              }
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour: selectedDate!.hour, 
                                  minute: selectedDate!.minute,
                                ),
                              );
                              
                              if (pickedTime != null) {
                                setStateDialog(() {
                                  selectedDate = DateTime(
                                    selectedDate!.year,
                                    selectedDate!.month,
                                    selectedDate!.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                  errorMsg = '';
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: isUrgent,
                          onChanged: (val) {
                            setStateDialog(() {
                              isUrgent = val ?? false;
                            });
                          },
                        ),
                        const Text("Tandai sebagai urgent", style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                    if (errorMsg.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(errorMsg, style: const TextStyle(color: Colors.red, fontSize: 12)),
                      ),
                  ],
                ),
              ),
              actions: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      if (textController.text.trim().isEmpty) {
                        setStateDialog(() => errorMsg = "Isi pengumuman tidak boleh kosong");
                        return;
                      }
                      if (selectedDate == null) {
                        setStateDialog(() => errorMsg = "Tanggal harus dipilih");
                        return;
                      }
                      
                      if (selectedDate!.isBefore(DateTime.now().subtract(const Duration(minutes: 5)))) {
                        setStateDialog(() => errorMsg = "Tanggal tidak boleh kurang dari waktu saat ini");
                        return;
                      }

                      setState(() {
                        final formattedDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')} ${selectedDate!.hour.toString().padLeft(2, '0')}:${selectedDate!.minute.toString().padLeft(2, '0')}:00";
                        if (existingItem == null) {
                          // Add new
                          _announcements.add({
                            "id": DateTime.now().millisecondsSinceEpoch,
                            "text": textController.text,
                            "date": formattedDate,
                            "isUrgent": isUrgent,
                          });
                        } else {
                          // Update existing
                          final index = _announcements.indexWhere((element) => element['id'] == existingItem['id']);
                          if (index != -1) {
                            _announcements[index] = {
                              "id": existingItem['id'],
                              "text": textController.text,
                              "date": formattedDate,
                              "isUrgent": isUrgent,
                            };
                          }
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Simpan Pengumuman", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteAnnouncement(int index) {
    setState(() {
      _announcements.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "KELOLA PENGUMUMAN",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                icon: const Icon(Icons.add, size: 18),
                label: const Text("Tambah pengumuman", style: TextStyle(fontSize: 12)),
                onPressed: () => _showAddDialog(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _announcements.length,
              itemBuilder: (context, index) {
                final item = _announcements[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppRadius.large,
                    boxShadow: AppShadows.soft,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 12),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item['isUrgent'] ? Colors.red : Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['text'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['date'],
                              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_square, color: AppColors.primary, size: 20),
                        onPressed: () => _showAddDialog(existingItem: item),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                        onPressed: () => _deleteAnnouncement(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

