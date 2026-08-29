import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({"sender": "user", "text": text});
    });
    
    _messageController.clear();
    
    // MOCK AI RESPONSE / LOGIKA CHATBOT
    // Di sinilah kamu bisa mengatur logika bagaimana chatbot merespon pengguna.
    // Nanti, kamu bisa menyambungkannya dengan API Backend (seperti ChatGPT atau Dialogflow).
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (text.toLowerCase().contains("darurat")) {
          _messages.add({
            "sender": "bot",
            "text": "Silahkan menekan Informasi lalu scroll ke bawah untuk menghubungi kontak darurat"
          });
        } else {
          _messages.add({
            "sender": "bot",
            "text": "Terima kasih atas pesannya. Saat ini saya masih belajar, silakan tanyakan seputar aplikasi SIGAP."
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            _buildChatbotIcon(size: 30),
            const SizedBox(width: 12),
            const Text('ChatBot', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        elevation: 1,
        shadowColor: Colors.black12,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Halo, aku asisten kamu",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Ada yang bisa dibantu?",
                          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      bool isUser = msg["sender"] == "user";
                      return _buildChatBubble(msg["text"]!, isUser);
                    },
                  ),
          ),
          
          // Bottom Input Area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildChip("Panduan menggunakan aplikasi"),
                      _buildChip("Status sensor terkini"),
                      _buildChip("Titik aman"),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                decoration: const InputDecoration(
                                  hintText: "Ketik pesan...",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                onSubmitted: _sendMessage,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.send, color: AppColors.primary),
                              onPressed: () => _sendMessage(_messageController.text),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return GestureDetector(
      onTap: () => _sendMessage(text),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
        ),
        child: Text(text, style: const TextStyle(fontSize: 11, color: AppColors.textPrimary)),
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isUser) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _buildChatbotIcon(size: 30),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? Colors.white : AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 0),
                  bottomRight: Radius.circular(isUser ? 0 : 16),
                ),
                boxShadow: isUser ? AppShadows.soft : null,
                border: !isUser ? Border.all(color: AppColors.divider) : null,
              ),
              child: Text(
                text,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 32), // Spacer for user bubble
          ],
        ],
      ),
    );
  }

  Widget _buildChatbotIcon({double size = 40}) {
    return ClipOval(
      child: Image.asset(
        "assets/images/logo_chatbot.jpeg",
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

