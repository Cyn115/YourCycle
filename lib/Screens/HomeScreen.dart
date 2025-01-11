import 'package:flutter/material.dart';
import 'package:new2/Widgets/Text.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Switchbutton.dart';
import 'package:intl/intl.dart';
import 'package:new2/Widgets/SwitchTextSize.dart';
import 'package:new2/data/TextSize.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:new2/Widgets/divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final colors = modes[currentMode]!;

  int dateDifference = 0;
  int differenceToCurrentDate = 0;
  double progress = 0.0;
  double averageDifference = 0;

  @override
  void initState() {
    super.initState();
    _getStartDatesAndCalculateDifferences();
    _getAverageDifference();
    _getDateDifference();
  }

  Future<void> _getAverageDifference() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userId);
      final docSnapshot = await docRef.get();
      final average = docSnapshot['averageDifference'];

      setState(() {
        averageDifference = average ?? 0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please insert inputs',
            style: TextStyle(
                fontFamily: 'Regular', color: colors.contrastingcolor),
          ),
          backgroundColor: colors.secondarycolor,
        ),
      );
    }
  }

  Future<void> _getDateDifference() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userId);
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data['dateDifference'] != null) {
          setState(() {
            dateDifference = data['dateDifference'];
          });
        } else {
          setState(() {
            dateDifference = 0;
          });
        }
      }
    } catch (e) {
      print("Error fetching date difference: $e");
      setState(() {
        dateDifference = 0;
      });
    }
  }

  Future<void> _getStartDatesAndCalculateDifferences() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userId);

      final docSnapshot = await docRef.get();

      final startDatesList = docSnapshot['startDates'] as List<dynamic>;

      if (startDatesList.isNotEmpty) {
        final lastStartDate = DateTime.parse(startDatesList.last);
        final currentDate = DateTime.now();
        final diff = currentDate.difference(lastStartDate).inDays;

        setState(() {
          differenceToCurrentDate = diff;

          if (startDatesList.length >= 2) {
            final firstStartDate = DateTime.parse(startDatesList[0]);
            final secondStartDate = DateTime.parse(startDatesList[1]);
            dateDifference =
                (secondStartDate.difference(firstStartDate).inDays).abs();
          } else {
            dateDifference = 0;
          }
          if (dateDifference != 0) {
            progress = averageDifference / dateDifference;
          } else {
            progress = 0.0;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please insert inputs',
            style: TextStyle(
                fontFamily: 'Regular', color: colors.contrastingcolor),
          ),
          backgroundColor: colors.secondarycolor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = sizes[currentSize]!;

    String formattedDate =
        DateFormat('EEEE, MMMM d yyyy').format(DateTime.now());
    int result = dateDifference - differenceToCurrentDate;
    double progress = averageDifference / dateDifference;

    return Scaffold(
      backgroundColor: colors.primarycolor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubHeading(subheadingtext: formattedDate, textsize: size),
            const Space(),
            CircularPercentIndicator(
              radius: 140,
              lineWidth: 30,
              backgroundColor: colors.tertiarycolor,
              progressColor: colors.secondarycolor,
              animation: true,
              animationDuration: 2000,
              percent: progress,
              center: Center(
                child: ProgressText(
                    smallbodytext:
                        'You are \n ${(progress * 100).toStringAsFixed(1)}% \n through your cycle',
                    textsize: size),
              ),
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const Space(),
            SubHeading(
                subheadingtext: 'Your next period is in', textsize: size),
            const SmallSpace(),
            SmallBodyText(
              smallbodytext: '$result days',
              textsize: size,
            ),
          ],
        ),
      ),
    );
  }
}
