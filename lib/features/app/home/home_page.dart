import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/const/page_const.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';
import 'package:whatapp_clone/features/call/presentation/pages/call_history_page.dart';
import 'package:whatapp_clone/features/chart/presentation/pages/chart_page.dart';
import 'package:whatapp_clone/features/status/presentation/pages/status_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentTaIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    //* Listener for tab changes
    _tabController!.addListener(() {
      setState(() {
        _currentTaIndex = _tabController!.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WhatsApp",
          style: TextStyle(color: greyColor, fontWeight: FontWeight.w600),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: greyColor,
                  size: 28,
                ),
              ),
              SizedBox(width: 25),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: greyColor, size: 28),
              ),
              SizedBox(width: 10),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 28, color: greyColor),
                color: appBarColor,
                onSelected: (String value) {
                  if (value == 'Settings') {
                    Navigator.pushNamed(context, PageConst.settingsPage);
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                ],
              ),
            ],
          ),
        ],

        bottom: TabBar(
          labelColor: tabColor,
          unselectedLabelColor: greyColor,
          indicatorColor: tabColor,
          controller: _tabController,
          tabs: [
            Text(
              "Chats",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "Status",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "Calls",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      floatingActionButton: switchFloatingActionButtonOnTabTndex(
        _currentTaIndex,
      ),
      body: TabBarView(
        // controller : _tabController,
        controller: _tabController,
        children: [
          // Center(child: Text("Chats Page")),
          // Center(child: Text("Status Page")),
          // Center(child: Text("Calls Page")),
          ChartPage(),
          StatusPage(),
          CallHistoryPage(),
        ],
      ),
    );
  }

  FloatingActionButton switchFloatingActionButtonOnTabTndex(int index) {
    switch (index) {
      case 0:
        return FloatingActionButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
            //* contactUsersPage
            Navigator.pushNamed(context, PageConst.contactUsersPage);
          },
          backgroundColor: tabColor,
          child: const Icon(Icons.message, color: Colors.white),
        );
      case 1:
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: tabColor,
          child: const Icon(Icons.camera_alt_outlined, color: Colors.white),
        );
      case 2:
        return FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, PageConst.callContactsPage);
          },
          backgroundColor: tabColor,
          child: const Icon(Icons.add_call, color: Colors.white),
        );
      default:
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: tabColor,
          child: const Icon(Icons.message, color: Colors.white),
        );
    }
  }
}
