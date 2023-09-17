import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/models/chat_message.dart';
import 'package:dart_openai/dart_openai.dart';

class ChatApi {
  static const _model = 'gpt-4';

  ChatApi() {
    OpenAI.apiKey = dotenv.env["API_KEY"]!;
    // OpenAI.organization = api_org;
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.role,
                content: e.content,
              ))
          .toList(),
    );
    print("Init 5");
    return chatCompletion.choices.first.message.content;
  }
}

class GPTHandler {
  ChatApi api = ChatApi();

  String SYS_MSG =
      """You are a helpful assistant that suggests fulfilling, and very specific, non-ambiguous establishments for a user to spend their free time. The user will give you an available time slot and a location. Sometimes they will suggest a type of event they'd like to do as well.
Be extremely direct with your event title; Respond with the title and only the title.
Then, provide a very short description of the event on a new line.
Then, on a new line again, tell me the name of the establishment. Omit any extra input and give me just the name.""";

  GPTHandler() {}

  Future<String> ask(String message) async {
    try {
      List<ChatMessage> msgs = List.empty(growable: true);
      msgs.add(ChatMessage(SYS_MSG, OpenAIChatMessageRole.system));
      msgs.add(ChatMessage(message, OpenAIChatMessageRole.user));
      final response = await api.completeChat(msgs);
      return response;
    } catch (err) {
      return "";
    }
  }
}
