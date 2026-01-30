import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/const/page_const.dart';
import 'package:whatapp_clone/features/app/global/date/date_formats.dart';
import 'package:whatapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: profileWidget(),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 10,
                  child: Container(
                    width:25,
                    height:25,
                    decoration: BoxDecoration(
                      color: tabColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: backgroundColor, width: 2)
                    ),
                    child: Icon(Icons.add, size:20 ),
                  ),
                )
          
                 
              ]),
              Expanded( child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("My Status", style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w600,
                    ),),
                  SizedBox(height: 5,),
                  Text("Tap to add status update",
                   style: TextStyle(
                    fontSize: 14,
                     color: greyColor,
                     ),)
                ],
              ) ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, PageConst.myStatusPage);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Icon(
                    Icons.more_horiz,
                     color: greyColor.withValues(alpha: 0.5,
                     )               
                     ,),
                ),
              ),
              ]
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                ),
              child: Text("Recent updates", style: TextStyle(
                fontSize: 15,
                color: greyColor,
                fontWeight: FontWeight.w600
              ),),
            ),
              const SizedBox(height: 10,),
            
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 20,
              itemBuilder:(context,index){
                return ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                   
                    child: profileWidget(),
                  ),
                ),
                title: Text("Username",style: TextStyle(
                  fontSize: 16
                ),),
                subtitle: Text(formatDateTime(DateTime.now()), maxLines: 1, overflow: TextOverflow.ellipsis,),
                
                );
              },
            )
          ],
        ),
      )
    );
  }
}