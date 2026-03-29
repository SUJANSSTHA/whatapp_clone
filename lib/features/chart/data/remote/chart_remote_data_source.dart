import 'package:whatapp_clone/features/chart/domain/entities/message_enitiy.dart';

import '../../domain/entities/chat_entity.dart';

// import '../entities/chat_entity.dart';

abstract class ChartRemoteDataSource {
  // Future<List<Map<String, dynamic>>> getChartData();
  Future<void>sendMessage(ChatEntity chart, MessageEntity message);
  Stream<List<ChatEntity>> getMyChart(ChatEntity chart);
  Stream<List<MessageEntity>> getMessages(MessageEntity message);
  Future<void> deleteMessage(MessageEntity message);
  Future<void> deleteChat(ChatEntity chart);
}