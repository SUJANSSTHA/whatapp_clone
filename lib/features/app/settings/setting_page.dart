import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
  
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              children: [
                // *
                SizedBox(
                  height: 65,
                  width: 65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.5),
                    child: profileWidget(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(
                          // color: greyColor
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "while true {code()}",
                        style: TextStyle(color: greyColor),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.qr_code, color: tabColor, size: 30),
                // *
              ],
            ),
          ),
          SizedBox(height: 2),
          
          Divider(color: greyColor.withValues(alpha: 0.4), thickness: 0.4),
          SizedBox(height: 20),
          _settingItemWidget(
            title: "Account",
            desciption: "Security applications, change number",
            icon: Icons.key,
            onTap: () {},
          ),
          _settingItemWidget(
            title: "Privacy",
            desciption: "Block contacts, desappearing messages",
            icon: Icons.lock,
            onTap: () {},
          ),
          _settingItemWidget(
            title: "Chats",
            desciption: "Theme, wallpapers, chat history",
            icon: Icons.message,
            onTap: () {},
          ),
          _settingItemWidget(
            title: "Logout",
            desciption: "Logout from whatsApp clone",
            icon: Icons.exit_to_app ,
            onTap: () {},
          ),

        ],
      ),
    );
  }

  //* setting methods
  GestureDetector _settingItemWidget({
    String? title,
    String? desciption,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Icon(icon, color: greyColor, size: 30),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Text(
                  '$desciption',
                  style: TextStyle(fontSize: 14, color: greyColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
