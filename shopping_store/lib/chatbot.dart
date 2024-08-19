// ignore_for_file: camel_case_types, unused_import, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class chatbot extends StatefulWidget {
  const chatbot({super.key});
  @override
  State<chatbot> createState() => _chatbotState();
}

class _chatbotState extends State<chatbot> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String message) {
    setState(() {
      _messages.add({
        'text': message,
        'type': 'text',
        'timestamp': DateFormat('h:mm a').format(DateTime.now()),
      });
    });
    _controller.clear();
  }

  void _sendVoiceMessage() {
    setState(() {
      _messages.add({
        'type': 'voice',
        'duration': 16,
        'timestamp': DateFormat('h:mm a').format(DateTime.now()),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 225, 218, 218),
        title: Text("Chat"),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              // Handle video call
            },
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              // Handle voice call
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Align messages to the start of the row
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: message['type'] == 'text'
                              ? Colors.blue[100]
                              : Colors.green[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (message['type'] == 'text')
                              Text(
                                message['text'],
                                style: TextStyle(fontSize: 16.0),
                              )
                            else if (message['type'] == 'voice')
                              Row(
                                children: [
                                  Icon(Icons.mic),
                                  SizedBox(width: 8),
                                  Text(
                                      'Voice Message (${message['duration']}s)'),
                                ],
                              ),
                            SizedBox(height: 4.0),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                message['timestamp'],
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Write your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: _sendVoiceMessage,
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    // Handle file attachment
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: chatbot(),
  ));
}
