// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:whatapp_clone/features/app/global/widgets/profile_widget.dart';
// import 'package:whatapp_clone/features/app/theme/style.dart';
// import 'package:whatapp_clone/features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
// import 'package:whatapp_clone/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
// import 'package:whatapp_clone/features/user/presentation/cubit/user/user_cubit.dart';

// class ContactPage extends StatefulWidget {
//     final String uid;
//   const ContactPage({
//     Key? key,
//     required this.uid,
//   }) : super(key: key);

//   @override
//   State<ContactPage> createState() => _ContactPageState();
// }

// class _ContactPageState extends State<ContactPage> {
//   @override
//   void initState() {
//     // BlocProvider.of<GetDeviceNumberCubit>(context).getDeviceNumber();
//      BlocProvider.of<UserCubit>(context).getAllUsers();
//     BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Contacts"),
//       ),
//       body: BlocBuilder<GetDeviceNumberCubit, GetDeviceNumberState>(
//         builder: (context, state) {
          
//           if (state is GetDeviceNumberLoaded) {
//             final contacts = state.contacts;
//             return ListView.builder(
//               itemCount: contacts.length,
//               itemBuilder: (context, index) {
//                 final contact = contacts[index];
//                 return ListTile(
//                   leading: SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(25),
//                       child:Image.memory( contact.photo ?? Uint8List(0), fit: BoxFit.cover) ,
                      
//                       //  profileWidget(),
//                     ),
//                   ),
//                   title: Text("Username"),
//                   subtitle: Text("Hey there I'm using WhatsApp"),
//                 );
//               },
//             );
//           }
//           // return Loading();
//           return const Center(
//             child: CircularProgressIndicator(
//               color: tabColor,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';

import '../../chart/domain/entities/message_enitiy.dart';
import '../../user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import '../../user/presentation/cubit/user/user_cubit.dart';
import '../const/page_const.dart';
import '../global/widgets/profile_widget.dart';

class ContactsPage extends StatefulWidget {
  final String uid;

  const ContactsPage({super.key, required this.uid});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {


  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getAllUsers();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contacts"),
      ),
      body:BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context,state) {
          if(state is GetSingleUserLoaded) {
            final currentUser = state.singleUser;
             return BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if(state is UserLoaded) {
                 final contacts = state.users.where((user) => user.uid != widget.uid).toList();
          
          
                if(contacts.isEmpty) {
                  return const Center(
                    child: Text("No Contacts Yet"),
                  );
                }
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PageConst.singleChatPage,
                          arguments: MessageEntity(
                            senderUid: currentUser.uid,
                            recipientUid: contact.uid,
                            recipientName: contact.username,
                            senderName: currentUser.username,
                            senderProfile: currentUser.profileUrl,
                            recipientProfile: contact.profileUrl,
                          ),
                        );
                      },
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: profileWidget(imageUrl: contact.profileUrl),
                        ),
                      ),
                      title: Text("${contact.username}"),
                      subtitle: Text("${contact.status}"),
                    );
                  },
                );
              }
              if(state is UserFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 60),
                      const SizedBox(height: 20),
                      Text(
                        'Error loading contacts',
                        style: TextStyle(color: textColor, fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<UserCubit>(context).getAllUsers();
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
            },
          );
        }
        if(state is GetSingleUserFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 20),
                Text(
                  'Error loading user data',
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
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
      },
    ));
  }
}
    