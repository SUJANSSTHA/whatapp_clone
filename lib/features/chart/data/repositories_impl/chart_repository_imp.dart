import 'package:whatapp_clone/features/chart/domain/entities/chat_entity.dart';

import 'package:whatapp_clone/features/chart/domain/entities/message_enitiy.dart';

import '../../domain/repositories/chart_repositories.dart';
import '../remote/chart_remote_data_source.dart';

class ChartRepositoryImpl implements ChatRepository {

  final ChartRemoteDataSource remoteDataSource;

  ChartRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<void> deleteChat(ChatEntity chart) async=> remoteDataSource.deleteChat(chart);

  @override
  Future<void> deleteMessage(MessageEntity message) async=> remoteDataSource.deleteMessage(message);

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) {
    return remoteDataSource.getMessages(message);
  }

  @override
  Stream<List<ChatEntity>> getMyChart(ChatEntity chart) {
    return remoteDataSource.getMyChart(chart);
  }

  @override
  Future<void> sendMessage(ChatEntity chart, MessageEntity message) async {
    return await remoteDataSource.sendMessage(chart, message);
  }
  
  @override
  Future<void> seenMessageUpdate(MessageEntity message) async {
    return await remoteDataSource.seenMessageUpdate(message);
  }
  
  
  }