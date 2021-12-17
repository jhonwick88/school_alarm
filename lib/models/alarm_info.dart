import 'package:timezone/timezone.dart' as tz;

class AlarmInfo {
  int? id;
  String title;
  tz.TZDateTime alarmDateTime;
  bool? isPending;
  int gradientColorIndex;

  AlarmInfo(
      {this.id,
      required this.title,
      required this.alarmDateTime,
      this.isPending,
      required this.gradientColorIndex});

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: tz.TZDateTime.parse(tz.local, json["alarmDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}
