// import 'package:dart_openai/openai.dart';

// class ChatMessage {
//   ChatMessage(this.content, this.isUserMessage);

//   final String content;
//   final bool isUserMessage;
// }

// Future<String> completeChat(List<ChatMessage> messages) async {
//   final chatCompletion = await OpenAI.instance.chat.create(
//     model: 'gpt-3.5-turbo',
//     messages: [
//       ...previousMessages.map(
//         (e) => OpenAIChatCompletionChoiceMessageModel(
//           role: e.isUserMessage ? 'user' : 'assistant',
//           content: e.content,
//         ),
//       ),
//     ],
//   );
//   return chatCompletion.choices.first.message.content;
// }

// class ChatApi {
//   static const _model = 'gpt-3.5-turbo';

//   ChatApi() {
//     OpenAI.apiKey = openAiApiKey;
//     OpenAI.organization = openAiOrg;
//   }

//   Future<String> completeChat(List<ChatMessage> messages) async {
//     final chatCompletion = await OpenAI.instance.chat.create(
//       model: _model,
//       messages: messages
//           .map((e) => OpenAIChatCompletionChoiceMessageModel(
//                 role: e.isUserMessage ? 'user' : 'assistant',
//                 content: e.content,
//               ))
//           .toList(),
//     );
//     return chatCompletion.choices.first.message.content;
//   }
// }


// Future<String> completeChat(String message) async {
//   final chatCompletion = await OpenAI.instance.chat.create(
//     model: 'gpt-3.5-turbo',
//     messages: [
//       OpenAIChatCompletionChoiceMessageModel(
//         content: message,
//         role: 'user',
//       ),
//     ],
//   );
//   return chatCompletion.choices.first.message.content;
// }