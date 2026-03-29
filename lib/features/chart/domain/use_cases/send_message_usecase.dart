


import '../entities/chat_entity.dart';
import '../entities/message_enitiy.dart';
import '../repositories/chart_repositories.dart';

class SendMessageUseCase {

  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<void> call(ChatEntity chat, MessageEntity message) async {
    return await repository.sendMessage(chat, message);
  }
}