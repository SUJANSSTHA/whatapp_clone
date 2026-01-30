import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/const/page_const.dart';
import 'package:whatapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';
import 'package:intl/intl.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body:ListView.builder(
        itemCount: 20,
        itemBuilder:(context,index){
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, PageConst.singleChatPage);
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
            title: Text("Username"),
            subtitle: Text("Last message hi", maxLines: 1, overflow: TextOverflow.ellipsis,),
            trailing: Text(DateFormat.jm().format(DateTime.now()),
            style: TextStyle(fontSize: 13, color: greyColor,)
            ),
            ),
          );
        },
      ) 
    );
  }
}