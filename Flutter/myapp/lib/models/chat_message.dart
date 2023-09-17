import 'package:dart_openai/dart_openai.dart';

class ChatMessage {
  ChatMessage(this.content, this.role);

  final String content;
  final OpenAIChatMessageRole role;
}
