import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Switchbutton.dart';

class CalendarTable extends StatefulWidget {
  final void Function(DateTime) onDaySelected;

  const CalendarTable({super.key, required this.onDaySelected});

  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final colors = modes[currentMode]!;

    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2015, 1, 1),
      lastDay: DateTime.utc(2040, 12, 31),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        _onDaySelected(selectedDay, focusedDay);
        widget.onDaySelected(selectedDay); 
      },
      calendarFormat: _calendarFormat,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: colors.contrastingcolor,
          fontFamily: 'Bold',
        ),
        leftChevronIcon:
            Icon(Icons.chevron_left, color: colors.contrastingcolor),
        rightChevronIcon:
            Icon(Icons.chevron_right, color: colors.contrastingcolor),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: 14,
          color: colors.contrastingcolor,
          fontFamily: 'Bold',
        ),
        weekendStyle: TextStyle(
          fontSize: 14,
          color: colors.contrastingcolor,
          fontFamily: 'Bold',
        ),
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(
            fontSize: 16,
            color: colors.contrastingcolor,
            fontFamily: 'Regular'),
        weekendTextStyle: TextStyle(
          fontSize: 16,
          color: colors.contrastingcolor,
          fontFamily: 'Regular',
        ),
        todayTextStyle: TextStyle(
          fontSize: 16,
          color: colors.contrastingcolor,
          fontFamily: 'Regular',
        ),
        selectedTextStyle: TextStyle(
          fontSize: 16,
          color: colors.contrastingcolor,
          fontFamily: 'Regular',
        ),
        selectedDecoration: BoxDecoration(
          color: colors.primarycolor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: colors.contrastingcolor, width: 2),
        ),
        defaultDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: colors.contrastingcolor, width: 1),
        ),
        todayDecoration: BoxDecoration(
          color: colors.secondarycolor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: colors.contrastingcolor, width: 2),
        ),
        weekendDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: colors.contrastingcolor, width: 1),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }
}
