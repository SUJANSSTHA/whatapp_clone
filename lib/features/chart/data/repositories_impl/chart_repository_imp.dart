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
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Stream<List<ChatEntity>> getMyChart(ChatEntity chart) {
    // TODO: implement getMyChart
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(ChatEntity chart, MessageEntity message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
  
  @override
  Future<void> seenMessageUpdate(MessageEntity message) {
    // TODO: implement seenMessageUpdate
    throw UnimplementedError();
  }
  
  
  }