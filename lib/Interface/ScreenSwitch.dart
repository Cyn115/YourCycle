import 'package:flutter/material.dart';
import 'package:new2/Screens/CalendarScreen.dart';
import 'package:new2/Screens/HomeScreen.dart';
import 'package:new2/Screens/MenuScreen.dart';
import 'package:new2/Screens/StatScreen.dart';
import 'package:new2/Widgets/Pageswitchbutton.dart';
import 'package:new2/Widgets/Text.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Switchbutton.dart';
import 'package:new2/Widgets/SwitchTextSize.dart';
import 'package:new2/data/TextSize.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScreenSwitch extends StatefulWidget {
  const ScreenSwitch({required this.username, required this.email, super.key});

  final String username;
  final String email;

  @override
  State<ScreenSwitch> createState() => _ScreenSwitchState();
}

class _ScreenSwitchState extends State<ScreenSwitch> {
  int pageIndex = 0;

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  void switchPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  final pages = [
    HomeScreen(userId: FirebaseAuth.instance.currentUser?.uid ?? ''),
    const CalendarScreen(),
    StatScreen(userId: FirebaseAuth.instance.currentUser?.uid ?? '')
  ];

  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;
    final size = sizes[currentSize]!;

    return Scaffold(
      backgroundColor: colors.primarycolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppTitle(apptitletext: 'Your Cycle', textsize: size),
        centerTitle: true,
        backgroundColor: colors.secondarycolor,
        actions: [
          IconButton(
            color: colors.contrastingcolor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuScreen(
                    username: widget.username,
                    email: widget.email,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context, colors),
    );
  }

  Container buildMyNavBar(BuildContext conxtext, Mode colors) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: colors.secondarycolor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Pagebutton(
            iconbefore:
                Icon(Icons.calendar_month, color: colors.contrastingcolor),
            iconafter: Icon(Icons.calendar_month_outlined,
                color: colors.contrastingcolor),
            pageIndex: pageIndex,
            buttonfunction: () => switchPage(1),
            page: 1,
          ),
          Pagebutton(
            iconbefore: Icon(Icons.home, color: colors.contrastingcolor),
            iconafter:
                Icon(Icons.home_outlined, color: colors.contrastingcolor),
            pageIndex: pageIndex,
            buttonfunction: () => switchPage(0),
            page: 0,
          ),
          Pagebutton(
            iconbefore: Icon(Icons.analytics, color: colors.contrastingcolor),
            iconafter:
                Icon(Icons.analytics_outlined, color: colors.contrastingcolor),
            pageIndex: pageIndex,
            buttonfunction: () => switchPage(2),
            page: 2,
          ),
        ],
      ),
    );
  }
}
