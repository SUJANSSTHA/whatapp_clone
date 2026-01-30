import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as time_age;
import 'package:whatapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';
class MyStatusPage extends StatefulWidget {
  const MyStatusPage({super.key});

  @override
  State<MyStatusPage> createState() => _MyStatusPageState();
}

class _MyStatusPageState extends State<MyStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Status")),
      body:Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // shape: BoxShape.circle,
                    // color: Colors.grey,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: profileWidget(),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Text(time_age.format(
                    DateTime.now().subtract(Duration(seconds: DateTime.now().second),
                    
                    )
                  ),style: TextStyle(
                    fontSize: 17,
                  fontWeight: FontWeight.w500,
                  ),),
                ),

                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: greyColor.withValues(alpha: 0.5,),),
                  color: appBarColor,
                  iconSize: 28,
                  onSelected: (value) {
                    // Handle menu item selection
                  },
                  itemBuilder:(context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Delete',
                      child: GestureDetector(
                        onTap: (){},
                        
                        child: Text('Delete')),
                    ),
                  ]
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}