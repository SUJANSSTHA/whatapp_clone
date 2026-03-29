// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatapp_clone/features/chart/domain/entities/chat_entity.dart';


class ChartModel extends ChatEntity {
  final String? senderUid;
  final String? recipientUid;
  final String? senderName;
  final String? recipientName;
  final String? recentTextMessage;
  final Timestamp? createdAt;
  final String? senderProfile;
  final String? recipientProfile;
  final num? totalUnReadMessages;
  


    ChartModel({
    this.senderUid,
    this.recipientUid,
    this.senderName,
    this.recipientName,
    this.recentTextMessage,
    this.createdAt,
    this.senderProfile,
    this.recipientProfile,
    this.totalUnReadMessages
  }):super(
    senderUid: senderUid,
    recipientUid: recipientUid,
    senderName: senderName,
    recipientName: recipientName,
    recentTextMessage: recentTextMessage,
    createdAt: createdAt,
    senderProfile: senderProfile,
    recipientProfile: recipientProfile,
    totalUnReadMessages: totalUnReadMessages
  );

factory ChartModel.fromSnapshot(DocumentSnapshot snapshot) {
  final snap = snapshot.data() as Map<String, dynamic>;
    return ChartModel(
      senderUid: snap['senderUid'],
      recipientUid: snap['recipientUid'],
      senderName: snap['senderName'],
      recipientName: snap['recipientName'],
      recentTextMessage: snap['recentTextMessage'],
      createdAt: snap['createdAt'],
      senderProfile: snap['senderProfile'],
      recipientProfile: snap['recipientProfile'],
      totalUnReadMessages: snap['totalUnReadMessages']
    );
  }

  Map<String, dynamic> toDocument()=> {
    'senderUid': senderUid,
    'recipientUid': recipientUid,
    'senderName': senderName,
    'recipientName': recipientName,
    'recentTextMessage': recentTextMessage,
    'createdAt': createdAt,
    'senderProfile': senderProfile,
    'recipientProfile': recipientProfile,
    'totalUnReadMessages': totalUnReadMessages
  };
  
}
