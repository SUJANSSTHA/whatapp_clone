import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatapp_clone/features/app/const/firebase_collection_const.dart';
import 'package:whatapp_clone/features/chart/data/models/chart_models.dart';
import 'package:whatapp_clone/features/chart/domain/entities/chat_entity.dart';

import 'package:whatapp_clone/features/chart/domain/entities/message_enitiy.dart';
import 'package:uuid/uuid.dart';
import '../../../app/const/message_type_const.dart';
import '../models/message_model.dart';
import 'chart_remote_data_source.dart';

class ChartRemoteDataSourceImpl implements ChartRemoteDataSource {
  
  final FirebaseFirestore firestore;
  ChartRemoteDataSourceImpl({required this.firestore});


 @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) async{

  
    await sendMessageBasedOnType(message);
    String recentTextMessage = "";
    
       switch (message.messageType) {
      case MessageTypeConst.photoMessage:
        recentTextMessage = '📷 Photo';
        break;
      case MessageTypeConst.videoMessage:
        recentTextMessage = '📸 Video';
        break;
      case MessageTypeConst.audioMessage:
        recentTextMessage = '🎵 Audio';
        break;
      case MessageTypeConst.gifMessage:
        recentTextMessage = 'GIF';
        break;
      default:
        recentTextMessage = message.message!;
    }



    await addToChart(ChatEntity(
      createdAt: chat.createdAt,
      senderProfile: chat.senderProfile,
      recipientProfile: chat.recipientProfile,
      recentTextMessage: recentTextMessage,
      // recentTextMessage: message.message,
      recipientName: chat.recipientName,
      senderName: chat.senderName,
      recipientUid: chat.recipientUid,
      senderUid: chat.senderUid,
      totalUnReadMessages: chat.totalUnReadMessages
    ));
  }

Future<void> addToChart(ChatEntity chat) async {



//* users -> senderUid -> myChat -> recipientUid -> message

  final myChatRef = firestore.collection(FirebaseCollectionConst.users).doc(chat.senderUid)
  .collection(FirebaseCollectionConst.myChat);

  final otherChatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.recipientUid)
        .collection(FirebaseCollectionConst.myChat);

          final myNewChat = ChartModel(
      createdAt: chat.createdAt,
      senderProfile: chat.senderProfile,
      recipientProfile: chat.recipientProfile,
      recentTextMessage: chat.recentTextMessage,
      recipientName: chat.recipientName,
      senderName: chat.senderName,
      recipientUid: chat.recipientUid,
      senderUid: chat.senderUid,
      totalUnReadMessages: chat.totalUnReadMessages,
    ).toDocument();

    final otherNewChat = ChartModel(
        createdAt: chat.createdAt,
        senderProfile: chat.recipientProfile,
        recipientProfile: chat.senderProfile,
        recentTextMessage: chat.recentTextMessage,
        recipientName: chat.senderName,
        senderName: chat.recipientName,
        recipientUid: chat.senderUid,
        senderUid: chat.recipientUid,
        totalUnReadMessages: chat.totalUnReadMessages)
        .toDocument();

        try {
      myChatRef.doc(chat.recipientUid).get().then((myChatDoc) async {
        // Create
        if (!myChatDoc.exists) {
          await myChatRef.doc(chat.recipientUid).set(myNewChat);
          await otherChatRef.doc(chat.senderUid).set(otherNewChat);
          return;
        } else {
          // Update
          await myChatRef.doc(chat.recipientUid).update(myNewChat);
          await otherChatRef.doc(chat.senderUid).update(otherNewChat);
          return;
        }
      });
    } catch (e) {
      print("error occur while adding to chat");
    }
  
} 
Future<void> sendMessageBasedOnType(MessageEntity message) async {

  // users -> senderUid -> myChat -> recipientUid -> messageid -> message
  final myMessageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages);

    final otherMessageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.messages);

        String messageId = const Uuid().v1();

    final newMessage = MessageModel(
        senderUid: message.senderUid,
        recipientUid: message.recipientUid,
        senderName: message.senderName,
        recipientName: message.recipientName,
        createdAt: message.createdAt,
        repliedTo: message.repliedTo,
        repliedMessage: message.repliedMessage,
        isSeen: message.isSeen,
        messageType: message.messageType,
        message: message.message,
        messageId: messageId,
        repliedMessageType: message.repliedMessageType)
        .toDocument();

        try{
          await myMessageRef.doc(messageId).set(newMessage);
          await otherMessageRef.doc(messageId).set(newMessage);}catch(e){
            print("error occur while sending message");
          }

}

  @override
  Future<void> deleteChat(ChatEntity chart) async{
  final chatRef = firestore
  .collection(FirebaseCollectionConst.users)
  .doc(chart.senderUid)
  .collection(FirebaseCollectionConst.myChat)
  .doc(chart.recipientUid);
  
  // await chatRef.delete();

   try {
      await chatRef.delete();
    } catch (e) {
      print("error occur while deleting chat");
    }

  }

  @override
  Future<void> deleteMessage(MessageEntity message)async {
    final messageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages)
        .doc(message.messageId);

    try {
      await messageRef.delete();
    } catch (e) {
      print("error occur while deleting message");
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) {
    final messageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages)
        .orderBy("createdAt", descending: false);

      return messageRef.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => MessageModel.fromSnapshot(e)).toList());

   
  }

  @override
  Stream<List<ChatEntity>> getMyChart(ChatEntity chart) {
    final myChatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chart.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .orderBy("createdAt", descending: true);

    return myChatRef.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => ChartModel.fromSnapshot(e)).toList());
  }

 
 
}