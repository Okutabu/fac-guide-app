import 'package:fac_guide/core/chatgpt/domain/chatgpt_chat.dart';
import 'package:fac_guide/chatgpt/data/network/chatgpt_response_dto.dart';

abstract class ChatGptApiService {
  Future<ChatGptResponseDto?> fetchResponse(ChatGptChat chatGptChat, String question);
}
