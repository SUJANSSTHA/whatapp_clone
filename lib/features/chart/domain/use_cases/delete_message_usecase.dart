



import '../entities/message_enitiy.dart';
import '../repositories/chart_repositories.dart';

class DeleteMessageUseCase {

  final ChatRepository repository;

  DeleteMessageUseCase({required this.repository});

  Future<void> call(MessageEntity message) async {
    return await repository.deleteMessage(message);
  }
}