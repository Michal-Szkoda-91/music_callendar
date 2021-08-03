import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:music_callendar/databaseHelper/databaseHelper.dart';
import 'package:music_callendar/models/music_day_event.dart';
import 'package:table_calendar/table_calendar.dart';

import '../builders/default_builder.dart';
import '../builders/holiday_builder.dart';
import '../builders/selected_day_builder.dart';
import '../builders/today_builder.dart';
import 'adding_event_button.dart';

class CustomTableCalendar extends StatefulWidget {
  CustomTableCalendar({Key? key}) : super(key: key);

  @override
  _CustomTableCalendarState createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DatabaseHelper helper = DatabaseHelper();
  late MusicEvent event;

  Future<void> getSelectedDayEvent() async {
    String chosenDate = DateFormat.yMd('pl_PL').format(_selectedDay);
    event = await helper.getData(chosenDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          availableGestures: AvailableGestures.horizontalSwipe,
          locale: 'pl_PL',
          calendarFormat: CalendarFormat.month,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(2000),
          lastDay: DateTime.utc(2200),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
          ),
          holidayPredicate: (day) {
            if (day.weekday == 6 || day.weekday == 7) {
              return true;
            } else
              return false;
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, day, today) {
              return SelectedDayBuilder(day: day);
            },
            todayBuilder: (context, day, today) {
              return TodayBuilder(day: day);
            },
            holidayBuilder: (context, day, today) {
              return HolidayBuilder(day: day);
            },
            defaultBuilder: (context, day, today) {
              return DefaultBuilder(day: day);
            },
          ),
        ),
        Spacer(),
        AddingEventButton(
          dateTime: _focusedDay,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        FutureBuilder(
          future: getSelectedDayEvent(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading....');
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Text('Result: ${event.id}');
            }
          },
        ),
      ],
    );
  }
}
