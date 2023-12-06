import 'dart:convert';

import 'package:fac_guide/core/chatgpt/domain/chatgpt_chat.dart';
import 'package:fac_guide/core/chatgpt/domain/chatgpt_config.dart';
import 'package:fac_guide/chatgpt/data/network/chatgpt_api_service.dart';
import 'package:fac_guide/chatgpt/data/network/chatgpt_response_dto.dart';
import 'package:dio/dio.dart';

class ChatGptApiServiceImpl implements ChatGptApiService {
  @override
  Future<ChatGptResponseDto?> fetchResponse(ChatGptChat chatGptChat, String question) async {
    const url = 'https://api.openai.com/v1/chat/completions';

    final dio = Dio()
      ..options.headers['Authorization'] = 'Bearer ${ChatGptConfig.apiKey}'
      ..options.headers['Content-Type'] = 'application/json';

    final requestBody = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'system',
          'content': '''
          ${ChatGptConfig.systemRole}
          Vous devez fournir des informations sur les installations et les services du campus. Veuillez répondre avec des détails sur l'emplacement des services ou des endroits spécifiques sur le campus.
          '''
              .trim(),
        },
        for (final chatLog in chatGptChat.chatLogs) chatLog,
        {'role': 'user', 'content': question},
      ],
    });

    print('mutant, chatGpt: Start Post');
    final Response<String> response = await dio.post(url, data: requestBody);
    print('mutant, chatGpt: End Post');
    final data = response.data;
    if (response.statusCode == 200 && data != null) {
      final answer = json.decode(data) as Map<String, dynamic>;
      final text = answer['choices'][0]['message']['content'] as String;
      print('mutant, chatGpt: Response: $text');
      return ChatGptResponseDto(text);
    } else {
      print('mutant, chatGpt: Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
