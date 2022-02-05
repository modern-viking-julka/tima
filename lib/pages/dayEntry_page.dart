import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';
import 'package:tima/data/database.dart';
import 'package:tima/models/day_entry.dart';

class DayEntryPage extends StatefulWidget {
  DayEntryPage({Key? key, @required this.dayEntryId, required this.dayDate})
      : super(key: key);

  final int? dayEntryId;
  final DateTime dayDate;

  @override
  _DayEntryPageState createState() => _DayEntryPageState();
}

class _DayEntryPageState extends State<DayEntryPage> {
  final _formKey = GlobalKey<FormState>();
  late Future<DayEntry> _dayEntry;

  @override
  void initState() {
    super.initState();
    _dayEntry = DBProvider.instance
        .getDayEntryById(widget.dayEntryId != null ? widget.dayEntryId! : 0);
  }

  TimeOfDay _startTime = TimeOfDay(hour: 0, minute: 0);
  TextEditingController _startTimeController =
      TextEditingController(text: '00:00');
  TimeOfDay _endTime = TimeOfDay(hour: 0, minute: 0);
  TextEditingController _endTimeController =
      TextEditingController(text: '00:00');
  // double _workingTimeIsDouble = _startTime.period
  // TextEditingController _workingTimeIsController =
  //     TextEditingController(text: '0.00');
  double _breakTime = 0.0;
  // String _breakTimeInit = '0.00';

  List<DropdownMenuItem<String>> _breakTimeList = [
    DropdownMenuItem<String>(child: Text('keine Pause'), value: '0.0'),
    DropdownMenuItem<String>(child: Text('15min'), value: '0.25'),
    DropdownMenuItem<String>(child: Text('30min'), value: '0.5'),
    DropdownMenuItem<String>(child: Text('1h'), value: '1.0'),
    DropdownMenuItem<String>(child: Text('1h15min'), value: '1.25'),
    DropdownMenuItem<String>(child: Text('1h30min'), value: '1.5'),
  ];
  String _breakTimeListValue = '0.0';

  //funktion for counting the working hours -JP(22.01.2022)
  double _calculateWorkingTimeIs(
      TimeOfDay startTime, TimeOfDay endTime, double breakTime) {
    double _doubleStartTime =
        startTime.hour.toDouble() + (startTime.minute.toDouble() / 60);
    double _doubleEndTime =
        endTime.hour.toDouble() + (endTime.minute.toDouble() / 60);
    double _timeDiff = 0.00;
    if (_doubleEndTime > _doubleStartTime) {
      _timeDiff = _doubleEndTime - _doubleStartTime - breakTime;
    }

    return _timeDiff;
  }

  Form buildDayEntryFutureForm(DayEntry dayData) {
    _startTime = dayData.startOfWork;
    _startTimeController.text = DateTime(
            widget.dayDate.year,
            widget.dayDate.month,
            widget.dayDate.day,
            _startTime.hour,
            _startTime.minute)
        .format('HH:mm', 'de_DE');
    _endTime = dayData.endOfWork;
    _endTimeController.text = DateTime(
            widget.dayDate.year,
            widget.dayDate.month,
            widget.dayDate.day,
            _endTime.hour,
            _endTime.minute)
        .format('HH:mm', 'de_DE');
    _breakTime = dayData.breakTime;
    _breakTimeListValue = dayData.breakTime.toString();
    // _workingTimeIsController.text = dayData.workingTimeIs.toString();

    return Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: _startTimeController,
                    readOnly: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      labelText: 'Arbeitsbeginn',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.grey),
                    onTap: () async {
                      TimeOfDay? timePicked = await showIntervalTimePicker(
                          context: context,
                          initialTime: dayData.startOfWork, // _startTime,
                          interval: 15,
                          visibleStep: VisibleStep.Fifteenths);
                      if (timePicked != null && timePicked != _startTime) {
                        _startTime = timePicked;
                        _startTimeController.text = DateTime(
                                widget.dayDate.year,
                                widget.dayDate.month,
                                widget.dayDate.day,
                                _startTime.hour,
                                _startTime.minute)
                            .format('HH:mm', 'de_DE');
                        dayData.workingTimeIs = _calculateWorkingTimeIs(
                            _startTime, _endTime, dayData.breakTime);
                        // _workingTimeIsController.text = _calculateWorkingTimeIs(
                        //         _startTime, _endTime, _breakTime)
                        //     .toString();
                        dayData.startOfWork = _startTime;
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: TextFormField(
                    controller: _endTimeController,
                    readOnly: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      labelText: 'Arbeitsende',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.grey),
                    onTap: () async {
                      TimeOfDay? endTimePicked = await showIntervalTimePicker(
                          context: context,
                          initialTime: dayData.endOfWork,
                          interval: 15,
                          visibleStep: VisibleStep.Fifteenths);
                      if (endTimePicked != null && endTimePicked != _endTime) {
                        _endTime = endTimePicked;
                        _endTimeController.text = DateTime(
                                widget.dayDate.year,
                                widget.dayDate.month,
                                widget.dayDate.day,
                                _endTime.hour,
                                _endTime.minute)
                            .format('HH:mm', 'de_DE');
                        dayData.workingTimeIs = _calculateWorkingTimeIs(
                            _startTime, _endTime, dayData.breakTime);
                        // _workingTimeIsController.text = _calculateWorkingTimeIs(
                        //         _startTime, _endTime, _breakTime)
                        //     .toString();
                        dayData.endOfWork = _endTime;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: DropdownButtonFormField(
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0)),
                        labelText: 'Pause',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                      items: _breakTimeList,
                      value: _breakTimeListValue,
                      // value: dayData.breakTime.toString(),
                      // value: _breakTime.toString(),
                      onChanged: (value) {
                        double _doubleValue = double.parse(value.toString());
                        dayData.workingTimeIs = _calculateWorkingTimeIs(
                            _startTime, _endTime, _breakTime);
                        // _workingTimeIsController.text = _calculateWorkingTimeIs(
                        //         _startTime, _endTime, _doubleValue)
                        //     .toString();
                        _breakTime = _doubleValue;
                        dayData.breakTime = _breakTime;
                        setState(() {});
                        dayData.breakTime = double.parse(value.toString());
                        // _breakTimeListValue = value.toString();
                      }),
                ),
                SizedBox(width: 20),
                Flexible(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Text('tgl. Ist-/Sollarbeitszeit',
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Ist:', style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 5),
                        // Text(_workingTimeIsController.text.toString() + ' h',
                        //     style: TextStyle(color: Colors.grey)),
                        Text(dayData.workingTimeIs.toString() + ' h',
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 5),
                        Text('/ Soll:', style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 5),
                        Text('7.5 h', style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                // SizedBox(width: 20),
                Flexible(
                    child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  initialValue: '7.50',
                  decoration: InputDecoration(
                    // icon: Icon(Icons.timer),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    labelText: 'tgl. Sollarbeitszeit',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.grey),
                ))
              ],
            ),
            SizedBox(height: 20),
            Text('Zusatzinformationen:', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context, false),
            color: Colors.blue,
          ),
          title: Text(
            widget.dayDate.format('EEEE dd.MM.yyyy', 'de_DE'),
            style: TextStyle(color: Colors.blue),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  int aktivUserId = await DBProvider.instance.getAktivUserId();
                  double workingTimeIs =
                      _calculateWorkingTimeIs(_startTime, _endTime, _breakTime);
                  DayEntry newDayEntry = DayEntry(
                      workDay: widget.dayDate,
                      startOfWork: _startTime,
                      endOfWork: _endTime,
                      breakTime: _breakTime,
                      workingTimeIs: workingTimeIs,
                      workingTimeShould: 7.5,
                      moreWorkPayed: 0,
                      moreWorkFreetime: 0,
                      travelTimePayedKey: '',
                      travelTimePayed: 0,
                      emergencyServiceTime: 0,
                      absenceReason: '',
                      userId: aktivUserId,
                      erledigt: 0);
                  if (widget.dayEntryId != null && widget.dayEntryId! > 0) {
                    newDayEntry.id = widget.dayEntryId;
                    await DBProvider.instance.updateDayEntry(newDayEntry);
                  } else {
                    await DBProvider.instance.newDayEntry(newDayEntry);
                  }
                  Navigator.pop(context, true);
                },
                child: Icon(
                  Icons.done,
                  size: 26.0,
                  color: Colors.blue,
                ),
              ),
            )
          ],
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder<DayEntry>(
            future: _dayEntry,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildDayEntryFutureForm(snapshot.data!));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}
