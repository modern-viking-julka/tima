import 'package:flutter/material.dart';

class DayEntry {
  int? id;
  DateTime workDay;
  TimeOfDay startOfWork;
  TimeOfDay endOfWork;
  double breakTime;
  double workingTimeIs;
  double workingTimeShould;
  double moreWorkPayed;
  double moreWorkFreetime;
  String travelTimePayedKey;
  double travelTimePayed;
  double emergencyServiceTime;
  String absenceReason;
  int userId;
  int erledigt;

  DayEntry({
    this.id,
    required this.workDay,
    required this.startOfWork,
    required this.endOfWork,
    required this.breakTime,
    required this.workingTimeIs,
    required this.workingTimeShould,
    required this.moreWorkPayed,
    required this.moreWorkFreetime,
    required this.travelTimePayedKey,
    required this.travelTimePayed,
    required this.emergencyServiceTime,
    required this.absenceReason,
    required this.userId,
    required this.erledigt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'workDay': workDay,
        'startOfWork': startOfWork,
        'endOfWork': endOfWork,
        'breakTime': breakTime,
        'workingTimeIs': workingTimeIs,
        'workingTimeShould': workingTimeShould,
        'moreWorkPayed': moreWorkPayed,
        'moreWorkFreetime': moreWorkFreetime,
        'travelTimePayedKey': travelTimePayedKey,
        'travelTimePayed': travelTimePayed,
        'emergencyServiceTime': emergencyServiceTime,
        'absenceReason': absenceReason,
        'userId': userId,
        'erledigt': erledigt,
      };

  factory DayEntry.fromMap(Map<String, dynamic> map) => new DayEntry(
        id: map['id'],
        workDay: DateTime.parse(map['workDay']),
        startOfWork: TimeOfDay.fromDateTime(DateTime.parse(map['startOfWork'])),
        endOfWork: TimeOfDay.fromDateTime(DateTime.parse(map['endOfWork'])),
        breakTime: map['breakTime'] != null ? map['breakTime'] : 0,
        workingTimeIs: map['workingTimeIs'] != null ? map['workingTimeIs'] : 0,
        workingTimeShould:
            map['workingTimeShould'] != null ? map['workingTimeShould'] : 0,
        moreWorkPayed: map['moreWorkPayed'] != null ? map['moreWorkPayed'] : 0,
        moreWorkFreetime:
            map['moreWorkFreetime'] != null ? map['moreWorkFreetime'] : 0,
        travelTimePayedKey:
            map['travelTimePayedKey'] != null ? map['travelTimePayedKey'] : '',
        travelTimePayed:
            map['travelTimePayed'] != null ? map['travelTimePayed'] : 0,
        emergencyServiceTime: map['emergencyServiceTime'] != null
            ? map['emergencyServiceTime']
            : 0,
        absenceReason: map['absenceReason'] != null ? map['absenceReason'] : '',
        userId: map['userId'],
        erledigt: map['erledigt'],
      );
}
