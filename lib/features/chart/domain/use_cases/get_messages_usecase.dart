

import '../entities/message_enitiy.dart';
import '../repositories/chart_repositories.dart';

class GetMessagesUseCase {

  final ChatRepository repository;

  GetMessagesUseCase({required this.repository});

  Stream<List<MessageEntity>> call(MessageEntity message)  {
    return repository.getMessages(message);
  }
}