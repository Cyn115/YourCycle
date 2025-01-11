import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new2/Widgets/Text.dart';
import 'package:new2/data/TextSize.dart';
import 'package:new2/Widgets/SwitchTextSize.dart';
import 'package:new2/Widgets/divider.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Switchbutton.dart';
import 'package:new2/Widgets/Calendar.dart';
import 'package:new2/Screens/InputScreen.dart';
import 'package:new2/Screens/periodScreen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _selectedDay;
  final Map<DateTime, Map<String, dynamic>> _events = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final colors = modes[currentMode]!;

  // Get current user
  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserEvents(); // Load events when the screen initializes
  }

  void _loadUserEvents() async {
    if (currentUser == null) {
      return;
    }

    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(currentUser!.uid);

      CollectionReference eventsCollection = userDocRef.collection('events');

      QuerySnapshot snapshot = await eventsCollection.get();

      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        DateTime eventDate = DateTime.parse(data['date']);
        Map<String, dynamic> eventData =
            Map<String, dynamic>.from(data['events']);
        setState(() {
          _events[eventDate] = eventData;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error loading events: $e',
            style: TextStyle(
                fontFamily: 'Regular', color: colors.contrastingcolor),
          ),
          backgroundColor: colors.secondarycolor,
        ),
      );
    }
  }

  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  void _addEvent(DateTime date, Map<String, dynamic> eventData) async {
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You need to log in first',
            style: TextStyle(
                fontFamily: 'Regular', color: colors.contrastingcolor),
          ),
          backgroundColor: colors.secondarycolor,
        ),
      );
      return;
    }

    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(currentUser!.uid);

      CollectionReference eventsCollection = userDocRef.collection('events');

      await eventsCollection.add({
        'date': date.toIso8601String(),
        'events': eventData,
      });

      setState(() {
        _events[date] = eventData;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Saved',
            style: TextStyle(
                fontFamily: 'Regular', color: colors.contrastingcolor),
          ),
          backgroundColor: colors.secondarycolor,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error loading event: $e',
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colors.primarycolor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              const SmallSpace(),
              if (_selectedDay != null && _events.containsKey(_selectedDay))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _events[_selectedDay]!
                      .entries
                      .where((entry) => entry.key != 'periodDuration')
                      .map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: colors.tertiarycolor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: screenWidth,
                        height: 60,
                        child: SmallBodyText(
                            smallbodytext: '${entry.key}: ${entry.value}',
                            textsize: size),
                      ),
                    );
                  }).toList(),
                ),
              const Space(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedDay != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InputScreen(
                                selectedDay: _selectedDay!,
                                onSubmit: _addEvent,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please select a day first.',
                                style: TextStyle(
                                    fontFamily: 'Regular',
                                    color: colors.contrastingcolor),
                              ),
                              backgroundColor: colors.secondarycolor,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.tertiarycolor,
                      ),
                      child: Icon(
                        Icons.event_note_rounded,
                        color: colors.contrastingcolor,
                        size: 35,
                      ),
                    ),
                    const SmallSpace(),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedDay != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PeriodScreen(
                                    startDay: _selectedDay!,
                                    userId: currentUser!.uid)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please select a day first.',
                                style: TextStyle(
                                    fontFamily: 'Regular',
                                    color: colors.contrastingcolor),
                              ),
                              backgroundColor: colors.secondarycolor,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.tertiarycolor,
                      ),
                      child: Icon(
                        Icons.add,
                        color: colors.contrastingcolor,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
