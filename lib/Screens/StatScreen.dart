import 'package:flutter/material.dart';
import 'package:new2/Widgets/divider.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Switchbutton.dart';
import 'package:new2/Widgets/Text.dart';
import 'package:new2/Widgets/SwitchTextSize.dart';
import 'package:new2/data/TextSize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({required this.userId, super.key});

  final String userId;

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  final colors = modes[currentMode]!;

  double averageDifference = 0;
  int inputCount = 0;
  List<DateTime> startDates = [];
  int dateDifference = 0;

  @override
  void initState() {
    super.initState();
    _getDateDifferences();
    _getStartDates();
  }

  Future<void> _getDateDifferences() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userId);

      final docSnapshot = await docRef.get();
      final dateDifferences = docSnapshot['dateDifferences'] as List<dynamic>;

      inputCount = dateDifferences.length;
      if (inputCount > 0) {
        final totalDifference = dateDifferences.fold<int>(
          0,
          (previousValue, element) => previousValue + (element as int),
        );
        averageDifference = totalDifference / inputCount;

        await docRef.update({'averageDifference': averageDifference});
      }

      setState(() {});
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

  Future<void> _getStartDates() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userId);

      final docSnapshot = await docRef.get();
      final startDatesList = docSnapshot['startDates'] as List<dynamic>;

      startDates = startDatesList
          .map((startDateStr) => DateTime.parse(startDateStr))
          .toList();

      if (startDates.length >= 2) {
        final currentStartDate = startDates[0];
        final nextStartDate = startDates[1];
        dateDifference =
            (nextStartDate.difference(currentStartDate).inDays).abs();

        final lastStartDate = startDates.last;
        final differenceToCurrentDate =
            DateTime.now().difference(lastStartDate).inDays;
        await docRef
            .update({'differenceToCurrentDate': differenceToCurrentDate});
        await docRef.update({'dateDifference': dateDifference});
      }

      setState(() {});
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
    double screenWidth = MediaQuery.of(context).size.width;
    final size = sizes[currentSize]!;

    return Container(
      color: colors.primarycolor,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Space(),
            Container(
              width: screenWidth * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.tertiarycolor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(headingtext: 'Period Length', textsize: size),
                  const SizedBox(height: 1),
                  Container(
                    color: colors.contrastingcolor,
                    height: 2,
                    width: size.headingsize * 7.2,
                  ),
                  const Space(),
                  Align(
                      alignment: Alignment.center,
                      child: BigBodyText(
                          bigbodytext:
                              '${averageDifference.toStringAsFixed(2)} days',
                          textsize: size)),
                ],
              ),
            ),
            const Space(),
            Container(
              width: screenWidth * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.tertiarycolor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(headingtext: 'Cycle Length', textsize: size),
                  const SizedBox(height: 1),
                  Container(
                    color: colors.contrastingcolor,
                    height: 2,
                    width: size.headingsize * 6.6,
                  ),
                  const Space(),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        if (startDates.length < 2)
                          BigBodyText(
                              bigbodytext: 'Not enough data', textsize: size)
                        else
                          BigBodyText(
                              bigbodytext: '$dateDifference days',
                              textsize: size)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
