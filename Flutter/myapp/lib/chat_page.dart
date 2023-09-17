import 'package:dart_openai/dart_openai.dart';
import 'package:myapp/api/chat_api.dart';
import 'package:myapp/models/chat_message.dart';
import 'package:myapp/widgets/message_bubble.dart';
import 'package:myapp/widgets/message_composer.dart';
import 'package:flutter/material.dart';
import 'package:yelp_fusion_client/models/hours.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.chatApi,
    super.key,
  });

  final ChatApi chatApi;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messages = <ChatMessage>[
    ChatMessage('Hello, how can I help?', OpenAIChatMessageRole.assistant),
  ];
  var _awaitingResponse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ..._messages.map(
                  (msg) => MessageBubble(
                    content: msg.content,
                    isUserMessage: msg.role == OpenAIChatMessageRole.user,
                  ),
                ),
              ],
            ),
          ),
          MessageComposer(
            onSubmitted: _onSubmitted,
            awaitingResponse: _awaitingResponse,
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmitted(String message) async {
    setState(() {
      _messages.add(ChatMessage(message, OpenAIChatMessageRole.user));
      _awaitingResponse = true;
    });
    try {
      final response = await widget.chatApi.completeChat(_messages);
      setState(() {
        _messages.add(ChatMessage(response, OpenAIChatMessageRole.assistant));
        _awaitingResponse = false;
      });
    } on RequestFailedException catch (err) {
      print(err.runtimeType);
      print(err.message);
      print(err.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
      setState(() {
        _awaitingResponse = false;
      });
    }
  }
}
