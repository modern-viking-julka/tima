import 'package:flutter/material.dart';
import 'package:tima/data/database.dart';
import 'package:tima/models/day_entry.dart';
import 'package:dart_date/dart_date.dart';

class TestingPage extends StatefulWidget {
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  Future<List<DayEntry>> fetchDayEntrysFromDatabase(
      BuildContext context) async {
    Future<List<DayEntry>> dayEntrys = DBProvider.instance.getDayEntrys('01');

    List<DayEntry> _testList = [];
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    var i = firstDayOfMonth.day;
    var iMax = lastDayOfMonth.day;
    while (i <= iMax) {
      DayEntry newDayEntry = DayEntry(
        id: i,
        workDay: DateTime(now.year, now.month, i, 0, 0, 0),
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
      _testList.add(newDayEntry);
      i++;
    }

    return _testList;
  }

  @override
  Widget build(BuildContext context) {
    var _dayEntrys = fetchDayEntrysFromDatabase(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Testing Form',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.black,
        ),
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
                            print("test click ${snapshot.data![index].id}");
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 8.0,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                // leading: Icon(Icons.event),
                                title: Text(snapshot.data![index].workDay
                                    .format('E dd.MM.yyyy', 'de_DE')),
                                subtitle: Text(
                                    '${snapshot.data![index].startOfWork.format(context)} - ${snapshot.data![index].endOfWork.format(context)} (${snapshot.data![index].workingTimeIs}h) Pause: ${snapshot.data![index].breakTime}h'),
                                trailing: Icon(Icons.arrow_forward),
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
}
