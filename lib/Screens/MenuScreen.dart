import 'package:flutter/material.dart';
import 'package:new2/Widgets/divider.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Switchbutton.dart';
import 'package:new2/Widgets/Text.dart';
import 'package:new2/Widgets/SwitchTextSize.dart';
import 'package:new2/data/TextSize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new2/Screens/WelcomeScreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({required this.username, required this.email, super.key});

  final String username;
  final String email;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<void> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("Successfully signed out.");
      } else {
        print("Error: User still logged in.");
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (route) => false,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to sign out: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final colors = modes[currentMode]!;
    final size = sizes[currentSize]!;

    return Scaffold(
      backgroundColor: colors.primarycolor,
      appBar: AppBar(
        title: AppTitle(apptitletext: 'Menu', textsize: size),
        centerTitle: true,
        backgroundColor: colors.secondarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading(headingtext: widget.username, textsize: size),
            const SizedBox(height: 10),
            SmallBodyText(smallbodytext: widget.email, textsize: size),
            SizedBox(
              width: screenWidth,
              child: Divider(
                color: colors.contrastingcolor,
                thickness: 2,
              ),
            ),
            const Space(),
            SubHeading(subheadingtext: 'App Preferences', textsize: size),
            const SizedBox(height: 5),
            Container(
              width: screenWidth,
              height: 168.0,
              decoration: BoxDecoration(
                color: colors.tertiarycolor,
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SmallBodyText(
                            smallbodytext: 'Dark Mode', textsize: size),
                        const Spacer(),
                        const SwitchExample(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SmallBodyText(smallbodytext: 'Text Size', textsize: size),
                    const SmallSpace(),
                    const SwitchTextSize(),
                  ],
                ),
              ),
            ),
            const Space(),
            SubHeading(subheadingtext: 'Options', textsize: size),
            const SmallSpace(),
            Container(
              width: screenWidth,
              height: 55,
              decoration: BoxDecoration(
                color: colors.tertiarycolor,
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: colors.primarycolor,
                            title: SubHeading(
                                subheadingtext: 'Confirm Log Out',
                                textsize: size),
                            content: SmallBodyText(
                                smallbodytext:
                                    'Are you sure you want to logout?',
                                textsize: size),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: SmallBodyText(
                                    smallbodytext: 'Cancel', textsize: size),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  logOut(context);
                                },
                                child: SmallBodyText(
                                    smallbodytext: 'OK', textsize: size),
                              )
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: colors.contrastingcolor,
                  ),
                  label:
                      SmallBodyText(smallbodytext: 'Log Out', textsize: size),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.tertiarycolor,
                ),
                child: SmallBodyText(smallbodytext: 'Back', textsize: size),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
