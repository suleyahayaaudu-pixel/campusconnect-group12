import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/app_config.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _typingTimer;
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = const [
    {
      'sender': 'System',
      'text': 'Welcome to CampusConnect Group 12 chat.',
      'time': 'Now',
      'isMe': false,
      'read': true,
    },
  ].toList();

  void _onTyping(String value) {
    setState(() => _isTyping = value.isNotEmpty);

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() => _isTyping = false);
      }
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'You',
        'text': text,
        'time': TimeOfDay.now().format(context),
        'isMe': true,
        'read': true,
      });

      _messages.add({
        'sender': 'Campus Bot',
        'text':
            'Message received. Group 12 unique constraint: ${AppConfig.uniqueConstraint}.',
        'time': TimeOfDay.now().format(context),
        'isMe': false,
        'read': true,
      });

      _controller.clear();
      _isTyping = false;
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _messageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'] == true;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 330),
        decoration: BoxDecoration(
          color: isMe ? AppConfig.primaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message['sender'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              message['text'],
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${message['time']}  ${message['read'] ? '✓✓ Read' : '✓ Sent'}',
              style: TextStyle(
                fontSize: 11,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Real-time Messaging'),
            Text(
              _isTyping ? 'typing...' : 'CampusConnect Chat',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppConfig.secondaryColor.withValues(alpha: 0.15),
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Group 12 Constraint: Inactive session timeout = 5 minutes',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messageBubble(_messages[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: _onTyping,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppConfig.primaryColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
