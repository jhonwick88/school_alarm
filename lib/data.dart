import 'package:school_alarm/enums.dart';
import 'package:school_alarm/models/alarm_info.dart';
import 'package:school_alarm/models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: "Waktu", imageSource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: "Alarm", imageSource: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.timer,
      title: "Timer", imageSource: 'assets/timer_icon.png'),
  MenuInfo(MenuType.stopwatch,
      title: "StopWatch", imageSource: 'assets/stopwatch_icon.png'),
];

List<AlarmInfo> alarmsItem = [
  AlarmInfo(
      id: 1,
      title: "Masuk Sekolah",
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      isPending: false,
      gradientColorIndex: 0),
  AlarmInfo(
      id: 2,
      title: "Istirahat",
      alarmDateTime: DateTime.now().add(Duration(hours: 3)),
      isPending: false,
      gradientColorIndex: 1),
  AlarmInfo(
      id: 3,
      title: "Istirahat II",
      alarmDateTime: DateTime.now().add(Duration(hours: 6)),
      isPending: false,
      gradientColorIndex: 2),
  AlarmInfo(
      id: 4,
      title: "Pulang Sekolah",
      alarmDateTime: DateTime.now().add(Duration(hours: 8)),
      isPending: false,
      gradientColorIndex: 3),
];
