import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:school_alarm/alarm_helper.dart';
import 'package:school_alarm/constants/theme_data.dart';
import 'package:school_alarm/main.dart';
import 'package:school_alarm/models/alarm_info.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late tz.TZDateTime _alarmTime;
  late String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  late List<AlarmInfo> _currentAlarms;

  @override
  void initState() {
    tz.initializeTimeZones();
    _alarmTime = tz.TZDateTime.now(tz.local);

    _alarmHelper.initializeDatabase().then((value) {
      print('-----------initial databse');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Alarm'),
          Expanded(
              child: FutureBuilder<List<AlarmInfo>>(
                  future: _alarms,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _currentAlarms = snapshot.data!;
                      return ListView(
                        children: snapshot.data!.map<Widget>((alarm) {
                          var alarmTime = DateFormat('hh:mm aa')
                              .format(alarm.alarmDateTime);
                          var gradientColor = GradientTemplate
                              .gradientTemplate[alarm.gradientColorIndex]
                              .colors;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 32),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: gradientColor,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: gradientColor.last.withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: Offset(4, 4),
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.label,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          alarm.title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir'),
                                        ),
                                      ],
                                    ),
                                    Switch(
                                      onChanged: (bool value) {},
                                      value: true,
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Text(
                                  'Mon-Fri',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir'),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      alarmTime,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'avenir',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        color: Colors.white,
                                        onPressed: () {
                                          deleteAlarm(alarm.id!);
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).followedBy([
                          if (_currentAlarms.length < 5)
                            DottedBorder(
                              strokeWidth: 2,
                              color: CustomColor.clockOutline,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(24),
                              dashPattern: [5, 4],
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: CustomColor.clockBG,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _alarmTimeString = DateFormat('HH:mm')
                                        .format(DateTime.now());
                                    showModalBottomSheet(
                                      useRootNavigator: true,
                                      context: context,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24),
                                        ),
                                      ),
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setModalState) {
                                            return Container(
                                              padding: const EdgeInsets.all(32),
                                              child: Column(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      var selectedTime =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      );
                                                      if (selectedTime !=
                                                          null) {
                                                        final now =
                                                            tz.TZDateTime.now(
                                                                tz.local);
                                                        //  tz.TZDateTime(selectedTime.hour,)
                                                        var selectedDateTime =
                                                            now.add(Duration(
                                                                hours:
                                                                    selectedTime
                                                                        .hour,
                                                                minutes:
                                                                    selectedTime
                                                                        .minute));

                                                        // DateTime(
                                                        //     now.year,
                                                        //     now.month,
                                                        //     now.day,
                                                        //     selectedTime
                                                        //         .hour,
                                                        //     selectedTime
                                                        //         .minute);
                                                        _alarmTime =
                                                            selectedDateTime;
                                                        setModalState(() {
                                                          _alarmTimeString =
                                                              DateFormat(
                                                                      'HH:mm')
                                                                  .format(
                                                                      selectedDateTime);
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      _alarmTimeString,
                                                      style: TextStyle(
                                                          fontSize: 32),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text('Repeat'),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                  ListTile(
                                                    title: Text('Sound'),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                  ListTile(
                                                    title: Text('Title'),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                  FloatingActionButton.extended(
                                                    onPressed: onSaveAlarm,
                                                    icon: Icon(Icons.alarm),
                                                    label: Text('Save'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                    // scheduleAlarm();
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/add_alarm.png',
                                        scale: 1.5,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Add Alarm',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'avenir'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            Center(
                                child: Text(
                              'Only 5 alarms allowed!',
                              style: TextStyle(color: Colors.white),
                            )),
                        ]).toList(),
                      );
                    }
                    return Center(
                      child: Text(
                        'Loading..',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void onSaveAlarm() {
    tz.TZDateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(tz.TZDateTime.now(tz.local)))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms();
  }

  void scheduleAlarm(
      tz.TZDateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'pintarmedia_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('pintarmedia_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
    // await flutterLocalNotificationsPlugin.schedule(0, 'Office', alarmInfo.title,
    //     scheduledNotificationDateTime, platformChannelSpecifics);
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}