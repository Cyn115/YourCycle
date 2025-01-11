import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new2/Widgets/Text.dart';
import 'package:new2/data/TextSize.dart';
import 'package:new2/Widgets/SwitchTextSize.dart';
import 'package:new2/Widgets/divider.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Switchbutton.dart';
import 'package:new2/Widgets/Calendar.dart';
import 'package:intl/intl.dart';

class PeriodScreen extends StatefulWidget {
  const PeriodScreen({required this.startDay, required this.userId, super.key});

  final DateTime startDay;
  final String userId;

  @override
  State<PeriodScreen> createState() => _PeriodScreenState();
}

class _PeriodScreenState extends State<PeriodScreen> {
  final colors = modes[currentMode]!;

  DateTime? _endDay;

  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _endDay = selectedDay;
    });
  }

  Future<void> _saveDatesToFirebase() async {
    try {
      if (_endDay == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please select an end date.',
              style: TextStyle(
                  fontFamily: 'Regular', color: colors.contrastingcolor),
            ),
            backgroundColor: colors.secondarycolor,
          ),
        );
        return;
      }

      if (_endDay!.isBefore(widget.startDay)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'End date cannot be before the start date.',
              style: TextStyle(
                  fontFamily: 'Regular', color: colors.contrastingcolor),
            ),
            backgroundColor: colors.secondarycolor,
          ),
        );
        return;
      }

      final docRef =
          FirebaseFirestore.instance.collection('users').doc(widget.userId);

      final dateDifference = _endDay!.difference(widget.startDay).inDays;

      await docRef.update({
        'startDay': widget.startDay.toIso8601String(),
        'endDay': _endDay!.toIso8601String(),
        'dateDifferences': FieldValue.arrayUnion([dateDifference]),
        'startDates':
            FieldValue.arrayUnion([widget.startDay.toIso8601String()]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Dates saved successfully!',
            style: TextStyle(
                fontFamily: 'Regular', color: colors.contrastingcolor),
          ),
          backgroundColor: colors.secondarycolor,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to save dates: $e',
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
    final startDate = DateFormat('d MMMM yyyy').format(widget.startDay);
    final endDate = _endDay != null
        ? DateFormat('d MMMM yyyy').format(_endDay!)
        : "Not selected";

    return Scaffold(
      backgroundColor: colors.primarycolor,
      appBar: AppBar(
        title: AppTitle(apptitletext: 'Your Cycle', textsize: size),
        centerTitle: true,
        backgroundColor: colors.secondarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: SubHeading(
                    subheadingtext: 'Select End of Period Date',
                    textsize: size),
              ),
              const Space(),
              Container(
                decoration: BoxDecoration(
                  color: colors.tertiarycolor,
                  borderRadius: BorderRadius.circular(15),
                ),
                width: screenWidth,
                height: 400,
                child: CalendarTable(
                  onDaySelected: _onDaySelected,
                ),
              ),
              const Space(),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: colors.tertiarycolor,
                  borderRadius: BorderRadius.circular(15),
                ),
                width: screenWidth,
                height: size.subheadingsize * 4 * 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SubHeading(
                        subheadingtext: 'Start of Period Date: ',
                        textsize: size),
                    SmallBodyText(smallbodytext: startDate, textsize: size),
                    const SmallSpace(),
                    SubHeading(
                        subheadingtext: 'End of Period Date: ', textsize: size),
                    SmallBodyText(smallbodytext: endDate, textsize: size),
                  ],
                ),
              ),
              const Space(),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _saveDatesToFirebase();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.tertiarycolor,
                  ),
                  child: Icon(
                    Icons.arrow_right_alt_rounded,
                    color: colors.contrastingcolor,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
