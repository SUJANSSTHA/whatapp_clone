import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/global/date/date_formats.dart';
import 'package:whatapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';

class CallHistoryPage extends StatelessWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body:SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                ),
              child: Text("Recent", style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w600
              ),),
            ),
            SizedBox(height: 5,),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 20,
              itemBuilder:(context,index){
                return ListTile(
                leading:Container(
                  width: 55,
                  height: 55,
                  // margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    // borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: profileWidget(),
                  ),
                    // child: profileWidget(),
                  ),
                  title: Text("Username",style: TextStyle(fontSize: 15),),
                  subtitle: Row(
                    children: [
                      Icon(Icons.call_made, size:19, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text(formatDateTime(DateTime.now())),
                    ],
                  ),
                  trailing: Icon(Icons.call, 
                  color: tabColor,
                   size: 25,
                   ),

                );
                
              },
            )
          ],
        ),
      )
    );
  }
}