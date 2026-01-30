import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/const/page_const.dart';
import 'package:whatapp_clone/features/app/home/contact_page.dart';
import 'package:whatapp_clone/features/app/settings/setting_page.dart';
import 'package:whatapp_clone/features/call/presentation/pages/call_contact_page.dart';
import 'package:whatapp_clone/features/chart/presentation/pages/single_chart_page.dart';
import 'package:whatapp_clone/features/status/presentation/pages/my_status_page.dart';


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
          return materialPageBuilder(const SettingPage());
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