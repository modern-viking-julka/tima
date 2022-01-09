import 'package:flutter/material.dart';

class DayEntry {
  final int? id;
  final DateTime workDay;
  final TimeOfDay startOfWork;
  final TimeOfDay endOfWork;
  final double breakTime;
  final double workingTimeIs;
  final double workingTimeShould;
  final double moreWorkPayed;
  final double moreWorkFreetime;
  final String travelTimePayedKey;
  final double travelTimePayed;
  final double emergencyServiceTime;
  final String absenceReason;
  final int userId;
  final int erledigt;

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
        userId: map['userId'],
        erledigt: map['erledigt'],
      );
}
