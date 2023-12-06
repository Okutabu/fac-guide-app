import 'package:fac_guide/core/chatgpt/data/chatgpt_repository.dart';
import 'package:fac_guide/core/chatgpt/domain/chatgpt_chat.dart';
import 'package:fac_guide/core/chatgpt/domain/chatgpt_response.dart';
import 'package:fac_guide/chatgpt/data/network/chatgpt_api_service.dart';

class ChatGptRepositoryImpl implements ChatGptRepository {
  ChatGptRepositoryImpl(this._chatGptApiService);

  final ChatGptApiService _chatGptApiService;

  @override
  Future<ChatGptResponse?> askQuestion(ChatGptChat chatGptChat, String question) async {
    final chatGptResponseDto = await _chatGptApiService.fetchResponse(chatGptChat, question);
    return chatGptResponseDto?.toChatGptResponse();
  }
}
