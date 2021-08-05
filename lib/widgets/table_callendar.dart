import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

import '../widgets/info_event_card.dart';
import '../databaseHelper/databaseHelper.dart';
import '../models/music_day_event.dart';
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
  late MusicEvent event =
      MusicEvent(id: '', playTime: 0, targetTime: 0, note: '');

  void getEvents(String id) async {
    event = MusicEvent(id: '', playTime: 0, targetTime: 0, note: '');
    try {
      final data = Provider.of<MusicEvents>(context, listen: false);
      event = data.findById(id);
    } catch (e) {}
  }

  @override
  void initState() {
    getEvents(DateFormat.yMd('pl_PL').format(_selectedDay));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MusicEvents>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
              getEvents(DateFormat.yMd('pl_PL').format(selectedDay));
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, day, today) {
                return SelectedDayBuilder(
                  day: day,
                );
              },
              todayBuilder: (context, day, today) {
                return TodayBuilder(
                  day: day,
                );
              },
              holidayBuilder: (context, day, today) {
                return HolidayBuilder(
                  day: day,
                );
              },
              defaultBuilder: (context, day, today) {
                return DefaultBuilder(
                  day: day,
                );
              },
            ),
          ),
          Container(
            child: event.id == ''
                ? Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: AddingEventButton(
                      dateTime: _focusedDay,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: InfoEventCard(
                      dateTime: _focusedDay,
                      musicEvent: data.findById(
                          DateFormat.yMd('pl_PL').format(_selectedDay)),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
