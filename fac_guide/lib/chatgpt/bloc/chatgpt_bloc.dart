import 'package:fac_guide/core/chatgpt/domain/chatgpt_chat.dart';
import 'package:fac_guide/core/chatgpt/domain/chatgpt_response.dart';
import 'package:fac_guide/core/chatgpt/usecase/ask_chatgpt_use_case.dart';
import 'package:fac_guide/core/date_time_provider.dart';
import 'package:fac_guide/chatgpt/bloc/chatgpt_message_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatGptBloc extends Bloc<AskQuestionEvent, List<ChatGptMessageViewModel>> {
  ChatGptBloc(
    this._askChatGptUseCase,
    this._dateTimeProvider,
  ) : super(_initialState(_dateTimeProvider)) {
    _chatGptResponseViewModels.addAll(state);
    on<AskQuestionEvent>((event, emit) async {
      _chatGptResponseViewModels.add(
        ChatGptMessageViewModel.fromMe(
          message: event.question,
          timestamp: _dateTimeProvider.now(),
        ),
      );
      emit(_chatGptResponseViewModels);

      _chatGptResponseViewModels.add(
        ChatGptMessageViewModel.loading(timestamp: _dateTimeProvider.now()),
      );
      emit(_chatGptResponseViewModels);

      final chatGptResponse = await _askChatGptUseCase(_chatGptChat, event.question);
      print('mutant, chatGptResponse: $chatGptResponse');

      _chatGptResponseViewModels.removeLast();
      _chatGptResponseViewModels.add(
        ChatGptMessageViewModel.fromBot(
          chatGptResponse: chatGptResponse ?? ChatGptResponse('Erreur système, veuillez réessayer plus tard'),
          timestamp: _dateTimeProvider.now(),
        ),
      );
      emit(List.of(_chatGptResponseViewModels));

      if (chatGptResponse != null) {
        _chatGptChat.add(event.question, chatGptResponse.summary);
      }
    });
  }

  static List<ChatGptMessageViewModel> _initialState(DateTimeProvider dateTimeProvider) => [
        ChatGptMessageViewModel.fromBot(
          chatGptResponse: ChatGptResponse(
            'Bonjour, je suis votre expert du campus pour répondre à vos question. Plait-il?'.trim(),
          ),
          timestamp: dateTimeProvider.now(),
        )
      ];

  final ChatGptChat _chatGptChat = ChatGptChat();
  final List<ChatGptMessageViewModel> _chatGptResponseViewModels = [];
  final AskChatGptUseCase _askChatGptUseCase;
  final DateTimeProvider _dateTimeProvider;
}

class AskQuestionEvent {
  const AskQuestionEvent(this.question);

  final String question;
}
