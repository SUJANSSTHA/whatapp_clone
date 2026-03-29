import 'package:whatapp_clone/features/chart/domain/entities/chat_entity.dart';

import 'package:whatapp_clone/features/chart/domain/entities/message_enitiy.dart';

import 'chart_remote_data_source.dart';

class ChartRemoteDataSourceImpl implements ChartRemoteDataSource {
  
  @override
  Future<void> deleteChat(ChatEntity chart) {
    // TODO: implement deleteChat
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMessage(MessageEntity message) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

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
 
}