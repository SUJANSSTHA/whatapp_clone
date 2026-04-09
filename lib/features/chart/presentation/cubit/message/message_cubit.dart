import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatapp_clone/features/chart/domain/use_cases/delete_message_usecase.dart';
import 'package:whatapp_clone/features/chart/domain/use_cases/get_messages_usecase.dart';
import 'package:whatapp_clone/features/chart/domain/use_cases/seen_message_update_usecase.dart';
import 'package:whatapp_clone/features/chart/domain/use_cases/send_message_usecase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/user/git_all_users_usercase.dart';

import '../../../domain/entities/chat_entity.dart';
import '../../../domain/entities/message_enitiy.dart';
import '../../../domain/entities/message_reply_entity.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final DeleteMessageUseCase deleteMessageUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final GetAllUsersUsercase getAllUsersUsercase;
  final GetMessagesUseCase getMessagesUseCase;
  final SeenMessageUpdateUseCase seenMessageUpdateUseCase;
  StreamSubscription? _messageSubscription;

  MessageCubit(
      {required this.deleteMessageUseCase,
      required this.sendMessageUseCase,
      required this.getAllUsersUsercase,
      required this.getMessagesUseCase,
      required this.seenMessageUpdateUseCase})
      : super(MessageInitial());

  Future<void> getMessages({required MessageEntity message}) async {
    try {
      emit(MessageLoading());
      print('📨 Loading messages for: ${message.senderUid} <-> ${message.recipientUid}');

      final streamResponse = getMessagesUseCase.call(message);
      
      // Cancel any existing subscription
      _messageSubscription?.cancel();
      
      _messageSubscription = streamResponse.listen(
        (messages) {
          print('✅ Loaded ${messages.length} messages');
          if (!isClosed) {
            emit(MessageLoaded(messages: messages));
          }
        },
        onError: (error) {
          print('❌ Stream error: $error');
          if (!isClosed) {
            emit(MessageFailure());
          }
        },
        cancelOnError: true,
      );
    } on SocketException catch (e) {
      print('❌ Socket Exception: $e');
      emit(MessageFailure());
    } catch (e) {
      print('❌ Error loading messages: $e');
      emit(MessageFailure());
    }
  }

  Future<void> deleteMessage({required MessageEntity message}) async {
    try {
      await deleteMessageUseCase.call(message);
    } on SocketException {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }

  Future<void> sendMessage(
      {required ChatEntity chat, required MessageEntity message}) async {
    try {
      await sendMessageUseCase.call(chat, message);
    } on SocketException {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }

  Future<void> seenMessage({required MessageEntity message}) async {
    try {
      await seenMessageUpdateUseCase.call(message);
    } on SocketException {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }


  MessageReplayEntity messageReplay = MessageReplayEntity();

  MessageReplayEntity get getMessageReplay => MessageReplayEntity();

  set setMessageReplay(MessageReplayEntity messageReplay) {
    this.messageReplay = messageReplay;
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}


 

  

