import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatapp_clone/features/chart/domain/use_cases/delete_my_chat_usecase.dart';
import 'package:whatapp_clone/features/chart/domain/use_cases/get_my_chat_usecase.dart';
import '../../../domain/entities/chat_entity.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {

  final GetMyChatUseCase getMyChatUseCase;
  final DeleteMyChatUseCase deleteMyChatUseCase;
  StreamSubscription? _chatSubscription;

  ChatCubit({required this.getMyChatUseCase,
   required this.deleteMyChatUseCase})
    : super(ChatInitial());

    Future<void> getMyChat({required ChatEntity chat}) async {
    try {
      emit(ChatLoading());

      final streamResponse = getMyChatUseCase.call(chat);
      
      // Cancel any existing subscription
      _chatSubscription?.cancel();
      
      _chatSubscription = streamResponse.listen(
        (chatContacts) {
          if (!isClosed) {
            emit(ChatLoaded(chatContacts: chatContacts));
          }
        },
        onError: (_) {
          if (!isClosed) {
            emit(ChatFailure());
          }
        },
        onDone: () {
          // Stream completed
        },
      );

    } on SocketException {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }


   Future<void> deleteChat({required ChatEntity chat}) async {
    try {

      await deleteMyChatUseCase.call(chat);

    } on SocketException {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
