import 'package:fac_guide/core/chatgpt/domain/chatgpt_chat.dart';
import 'package:fac_guide/core/chatgpt/domain/chatgpt_response.dart';

abstract class ChatGptRepository {
  Future<ChatGptResponse?> askQuestion(ChatGptChat chatGptChat, String question);
}
