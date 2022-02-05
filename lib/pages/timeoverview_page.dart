import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:dart_date/dart_date.dart';
import 'package:tima/data/database.dart';
import 'package:tima/models/day_entry.dart';
import 'package:tima/pages/dayEntry_page.dart';

class TimeOverviewPage extends StatefulWidget {
  @override
  _TimeOverviewPageState createState() => _TimeOverviewPageState();
}

class _TimeOverviewPageState extends State<TimeOverviewPage> {
  DateTime selectedDate = DateTime.now();
  String currentMothStr = DateTime.now().format('MMMM yyyy', 'de_DE');

  @override
  Widget build(BuildContext context) {
    var _dayEntrys = fetchDayEntrysFromDatabase(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(
              currentMothStr,
              style: TextStyle(color: Colors.blue),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      showMonthPicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 1, 1),
                        lastDate:
                            DateTime(DateTime.now().year, DateTime.now().month),
                        initialDate: selectedDate,
                        locale: Locale('de', 'DE'),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                            currentMothStr = date.format('MMMM yyyy', 'de_DE');
                          });
                        }
                      });
                    },
                    child: Icon(
                      Icons.calendar_today,
                      size: 26.0,
                      color: Colors.blue,
                    ),
                  )),
            ],
            backgroundColor: Colors.black),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: FutureBuilder<List<DayEntry>>(
              future: _dayEntrys,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            //open DayEntry edit form if id not null, else insert form!
                            print("test click ${snapshot.data![index].id}");
                            Navigator.push(
                                context,
                                MaterialPageRoute<bool>(
                                  builder: (context) => DayEntryPage(
                                      dayEntryId: snapshot.data![index].id,
                                      dayDate: snapshot.data![index].workDay),
                                )).then((value) {
                              if (value!) {
                                print('Eintrag gespeichert!');
                                // if Data was saved there is need of setState! -JP(16.1.2022)
                                setState(() {});
                              } else {
                                print('Bearbeitung abgebrochen!...');
                              }
                            });
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 8.0,
                            // color: snapshot.data![index].id == null
                            //     ? Colors.red
                            //     : Colors.green,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                // leading: Icon(Icons.event),
                                leading: Container(
                                  width: 10,
                                  color: snapshot.data![index].id == null
                                      ? Colors.red
                                      : Colors.green,
                                ),
                                title: Text(snapshot.data![index].workDay
                                    .format('E dd.MM.yyyy', 'de_DE')),
                                subtitle: Text(
                                    '${snapshot.data![index].startOfWork.format(context)} - ${snapshot.data![index].endOfWork.format(context)} (${snapshot.data![index].workingTimeIs}h) Pause: ${snapshot.data![index].breakTime}h'),
                                // trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: const CircularProgressIndicator(),
                );
              }),
        ));
  }

  Future<List<DayEntry>> fetchDayEntrysFromDatabase(
      BuildContext context) async {
    List<DayEntry> _testList = [];

    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0);

    var i = firstDayOfMonth.day;
    var iMax = lastDayOfMonth.day; //show the whole month -JP(16.1.2022)
    // var iMax = selectedDate.day;
    DayEntry newDayEntry;

    while (i <= iMax) {
      //get the DayEntry out of database if exists -JP(16.1.2022)
      DayEntry? dbDayEntry = await DBProvider.instance
          .getDayEntry(DateTime(selectedDate.year, selectedDate.month, i));
      //if dbDayEntry is not null and hast data then use it for displaying the info -JP(16.1.2022)
      if (dbDayEntry != null) {
        newDayEntry = dbDayEntry;
      } else {
        newDayEntry = DayEntry(
          id: null,
          workDay: DateTime(selectedDate.year, selectedDate.month, i, 0, 0, 0),
          startOfWork: TimeOfDay(hour: 6, minute: 30),
          endOfWork: TimeOfDay(hour: 14, minute: 30),
          breakTime: 0.5,
          workingTimeIs: 7.5,
          workingTimeShould: 7.5,
          moreWorkPayed: 0,
          moreWorkFreetime: 0,
          travelTimePayedKey: '',
          travelTimePayed: 0,
          emergencyServiceTime: 0,
          absenceReason: '',
          userId: 1,
          erledigt: 0,
        );
      }
      _testList.add(newDayEntry);
      i++;
    }

    return _testList;
  }
}
