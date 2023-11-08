// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Presentacion {
  int? id;
  DateTime start_date;
  DateTime end_date;
  String title;
  String location;
  Bool all_day;
  Bool alarm;
  Reminder reminder;
  Presentacion({
    this.id,
    required this.start_date,
    required this.end_date,
    required this.title,
    required this.location,
    required this.all_day,
    required this.alarm,
    required this.reminder,
  });

  Presentacion copyWith({
    int? id,
    DateTime? start_date,
    DateTime? end_date,
    String? title,
    String? location,
    Bool? all_day,
    Bool? alarm,
    Reminder? reminder,
  }) {
    return Presentacion(
      id: id ?? this.id,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      title: title ?? this.title,
      location: location ?? this.location,
      all_day: all_day ?? this.all_day,
      alarm: alarm ?? this.alarm,
      reminder: reminder ?? this.reminder,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'start_date': start_date.millisecondsSinceEpoch,
      'end_date': end_date.millisecondsSinceEpoch,
      'title': title,
      'location': location,
      'all_day': all_day.toMap(),
      'alarm': alarm.toMap(),
      'reminder': reminder.toMap(),
    };
  }

  factory Presentacion.fromMap(Map<String, dynamic> map) {
    return Presentacion(
      id: map['id'] != null ? map['id'] as int : null,
      start_date: DateTime.fromMillisecondsSinceEpoch(map['start_date'] as int),
      end_date: DateTime.fromMillisecondsSinceEpoch(map['end_date'] as int),
      title: map['title'] as String,
      location: map['location'] as String,
      all_day: Bool.fromMap(map['all_day'] as Map<String, dynamic>),
      alarm: Bool.fromMap(map['alarm'] as Map<String, dynamic>),
      reminder: Reminder.fromMap(map['reminder'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Presentacion.fromJson(String source) =>
      Presentacion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Presentacion(id: $id, start_date: $start_date, end_date: $end_date, title: $title, location: $location, all_day: $all_day, alarm: $alarm, reminder: $reminder)';
  }

  @override
  bool operator ==(covariant Presentacion other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.start_date == start_date &&
        other.end_date == end_date &&
        other.title == title &&
        other.location == location &&
        other.all_day == all_day &&
        other.alarm == alarm &&
        other.reminder == reminder;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        start_date.hashCode ^
        end_date.hashCode ^
        title.hashCode ^
        location.hashCode ^
        all_day.hashCode ^
        alarm.hashCode ^
        reminder.hashCode;
  }
}

class Bool {
  final bool value;

  Bool(this.value);

  factory Bool.fromMap(Map<String, dynamic> map) {
    return Bool(map['value'] as bool);
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }
}

class Reminder {
  final int minutes;

  Reminder(this.minutes);

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(map['minutes'] as int);
  }

  Map<String, dynamic> toMap() {
    return {
      'minutes': minutes,
    };
  }
}
