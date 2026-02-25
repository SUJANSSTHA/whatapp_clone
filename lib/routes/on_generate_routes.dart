import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/const/page_const.dart';
import 'package:whatapp_clone/features/app/home/contact_page.dart';
import 'package:whatapp_clone/features/app/settings/setting_page.dart';
import 'package:whatapp_clone/features/call/presentation/pages/call_contact_page.dart';
import 'package:whatapp_clone/features/chart/presentation/pages/single_chart_page.dart';
import 'package:whatapp_clone/features/status/presentation/pages/my_status_page.dart';
import 'package:whatapp_clone/features/user/domain/entities/user_entity.dart';
import 'package:whatapp_clone/pages/edit_profile_page.dart';


class OnGenerateRoutes{

  static Route<dynamic>? route(RouteSettings settings) {
   final args = settings.arguments;
   final name = settings.name;
    switch (name) {
      case PageConst.contactUsersPage:
        {
          return materialPageBuilder(const ContactPage());
        }
      case PageConst.settingsPage:
        {
          if(args is String){

          return materialPageBuilder(SettingPage(uid: args,));
          }else{
            return materialPageBuilder(ErrorPage());
          }
        }
      case PageConst.editProfilePage:
        {
          if(args is UserEntity){

          return materialPageBuilder(EditProfilePage(currentUser: args,));
          }else{
            return materialPageBuilder(ErrorPage());
          }
        }
      case PageConst.myStatusPage:
        {
          return materialPageBuilder(const MyStatusPage());
        }
      case PageConst.callContactsPage:
        {
          return materialPageBuilder(const CallContactsPage());
        }
      case PageConst.singleChatPage:
        {
          return materialPageBuilder(const SingleChartPage());
        }
        
      default:
        return null;
    }
  }
}
dynamic materialPageBuilder(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error"),
      ),
      body: Center(
        child: Text("Error"),
      ),
    );
  }
}