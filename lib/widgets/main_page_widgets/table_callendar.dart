import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

import 'package:music_callendar/ads/ad_banner.dart';
import 'info_event_card.dart';
import '../../databaseHelper/databaseHelper.dart';
import '../../models/music_day_event.dart';
import '../../builders/default_builder.dart';
import '../../builders/holiday_builder.dart';
import '../../builders/selected_day_builder.dart';
import '../../builders/today_builder.dart';
import 'adding_event_button.dart';

class CustomTableCalendar extends StatefulWidget {
  CustomTableCalendar({Key? key}) : super(key: key);

  @override
  _CustomTableCalendarState createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DatabaseHelper helper = DatabaseHelper();
  late MusicEvent event =
      MusicEvent(id: '', playTime: 0, generalTime: 0, targetTime: 0, note: '');

  String _locale = Platform.localeName;

  void getEvents(String id) async {
    event = MusicEvent(
        id: '', playTime: 0, generalTime: 0, targetTime: 0, note: '');
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
    return FutureBuilder(
      future: _initGoogleMobileAds(),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: MediaQuery.of(context).orientation == Orientation.portrait
              //Portrait settings
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BannerContainer(),
                    _createTableCalendar(),
                    const SizedBox(height: 25),
                    _createCardContainer(data),
                  ],
                )
              // landscape settings
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: _createTableCalendar()),
                    Container(
                        // padding: const EdgeInsets.only(top: 60),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          children: [
                            BannerContainer(),
                            const SizedBox(height: 30),
                            _createCardContainer(data),
                          ],
                        )),
                  ],
                ),
        );
      },
    );
  }

  Widget _createCardContainer(MusicEvents data) {
    return data.findById(DateFormat.yMd('pl_PL').format(_selectedDay)).id == ''
        ? AddingEventButton(
            dateTime: _focusedDay,
          )
        : InfoEventCard(
            dateTime: _focusedDay,
            musicEvent:
                data.findById(DateFormat.yMd('pl_PL').format(_selectedDay)),
          );
  }

  TableCalendar<dynamic> _createTableCalendar() {
    var mediaQuery = MediaQuery.of(context);
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      locale: _locale,
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(
          color: Theme.of(context).textTheme.headline1!.color,
          fontSize: 18,
        ),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: Theme.of(context).primaryColor,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: Theme.of(context).primaryColor,
        ),
        formatButtonVisible: false,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        weekendStyle: TextStyle(
          color: Theme.of(context).errorColor,
        ),
      ),
      rowHeight: mediaQuery.orientation == Orientation.portrait
          ? mediaQuery.size.width / 7
          : (mediaQuery.size.width * 0.5) / 7,
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
    );
  }
}
