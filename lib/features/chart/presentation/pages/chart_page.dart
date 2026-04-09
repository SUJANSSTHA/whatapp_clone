import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatapp_clone/features/app/const/page_const.dart';
import 'package:whatapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';
import 'package:intl/intl.dart';
import 'package:whatapp_clone/features/chart/domain/entities/chat_entity.dart';
import 'package:whatapp_clone/features/chart/domain/entities/message_enitiy.dart';

import '../cubit/chat/chat_cubit.dart';

class ChartPage extends StatefulWidget {
  final String uid;
  const ChartPage({super.key, required this.uid});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getMyChat(
        chat: ChatEntity(
      senderUid: widget.uid,
    ));
    // BlocProvider.of<ChatCubit>(context).getMyChat(chat: ChatEntity(senderUid: "", senderName: "", senderProfile: "", recipientUid: "", recipientName: "", recipientProfile: "", recentTextMessage: ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      if (state is ChatLoaded) {
        final myChat = state.chatContacts;
        if (myChat.isEmpty) {
          return const Center(
            child: Text("No Conversation Yet"),
          );
        }
        return ListView.builder(
          itemCount: myChat.length,
          itemBuilder: (context, index) {
            final chat = myChat[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageConst.singleChatPage,
                    arguments: MessageEntity(
                      senderUid: chat.senderUid,
                      recipientUid: chat.recipientUid,
                      senderName: chat.senderName,
                      recipientName: chat.recipientName,
                      senderProfile: chat.senderProfile,
                      recipientProfile: chat.recipientProfile,
                    ));
              },
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: profileWidget(),
                  ),
                ),
                title: Text("${chat.recipientName}"),
                subtitle: Text(
                  "${chat.recentTextMessage}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(DateFormat.jm().format(chat.createdAt!.toDate()),
                    style: TextStyle(
                      fontSize: 13,
                      color: greyColor,
                    )),
              ),
            );
          },
        );
      }
      if (state is ChatFailure) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 20),
              Text(
                'Error loading chats',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ChatCubit>(context).getMyChat(
                    chat: ChatEntity(
                      senderUid: widget.uid,
                    ),
                  );
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(
          color: tabColor,
        ),
      );

      // if(chatContacts.isEmpty) {
      //   return const Center(
      //     child: Text("No Chats Yet"),
      //   );
      // }}
      // return ListView.builder(
      //   itemCount: 20,
      //   itemBuilder:(context,index){
      //     return GestureDetector(
      //       onTap: (){
      //         Navigator.pushNamed(context, PageConst.singleChatPage);
      //       },
      //       child: ListTile(
      //       leading: SizedBox(
      //         width: 50,
      //         height: 50,
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(25),

      //           child: profileWidget(),
      //         ),
      //       ),
      //       title: Text("Username"),
      //       subtitle: Text("Last message hi", maxLines: 1, overflow: TextOverflow.ellipsis,),
      //       trailing: Text(DateFormat.jm().format(DateTime.now()),
      //       style: TextStyle(fontSize: 13, color: greyColor,)
      //       ),
      //       ),
      //     );
      //   },
      // );
    }));
  }
}
