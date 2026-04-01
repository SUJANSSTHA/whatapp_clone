

import 'package:whatapp_clone/features/chart/domain/entities/message_enitiy.dart';

import '../repositories/chart_repositories.dart';

// class SeenMessageUpdateUseCase {

//   final ChatRepository repository;

//   SeenMessageUpdateUseCase({required this.repository});

  
// }

class SeenMessageUpdateUseCase {

  final ChatRepository repository;

  SeenMessageUpdateUseCase({required this.repository});

  Future<void> call(MessageEntity message) async {
    return await repository.seenMessageUpdate(message);
  }
}