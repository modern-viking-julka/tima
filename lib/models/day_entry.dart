import 'package:flutter/material.dart';

class DayEntry {
  final int? id;
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
      };

  factory DayEntry.fromMap(Map<String, dynamic> map) => new DayEntry(
        id: map['id'],
        workDay: map['workDay'],
        startOfWork: map['startOfWork'],
        endOfWork: map['endOfWork'],
        breakTime: map['breakTime'],
        workingTimeIs: map['workingTimeIs'],
        workingTimeShould: map['workingTimeShould'],
        moreWorkPayed: map['moreWorkPayed'],
        moreWorkFreetime: map['moreWorkFreetime'],
        travelTimePayedKey: map['travelTimePayedKey'],
        travelTimePayed: map['travelTimePayed'],
        emergencyServiceTime: map['emergencyServiceTime'],
        absenceReason: map['absenceReason'],
      );
}
