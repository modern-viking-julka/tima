import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';

class TimeOverviewPage extends StatefulWidget {
  @override
  _TimeOverviewPageState createState() => _TimeOverviewPageState();
}

class _TimeOverviewPageState extends State<TimeOverviewPage> {
  List _elements = [
    {
      'order': 1,
      'name': 'Mi. 1.12.2021',
      'group': 'Kalenderwoche 48 Dezember 2021'
    },
    {
      'order': 2,
      'name': 'Do. 2.12.2021',
      'group': 'Kalenderwoche 48 Dezember 2021'
    },
    {
      'order': 3,
      'name': 'Fr. 3.12.2021',
      'group': 'Kalenderwoche 48 Dezember 2021'
    },
    {
      'order': 4,
      'name': 'Sa. 4.12.2021',
      'group': 'Kalenderwoche 48 Dezember 2021'
    },
    {
      'order': 5,
      'name': 'So. 5.12.2021',
      'group': 'Kalenderwoche 48 Dezember 2021'
    },
    {
      'order': 6,
      'name': 'Mo. 6.12.2021',
      'group': 'Kalenderwoche 49 Dezember 2021'
    },
    {
      'order': 7,
      'name': 'Di. 7.12.2021',
      'group': 'Kalenderwoche 49 Dezember 2021'
    },
    {
      'order': 8,
      'name': 'Mi. 8.12.2021',
      'group': 'Kalenderwoche 49 Dezember 2021'
    },
    {
      'order': 9,
      'name': 'Do. 9.12.2021',
      'group': 'Kalenderwoche 49 Dezember 2021'
    },
    {
      'order': 10,
      'name': 'Fr. 10.12.2021',
      'group': 'Kalenderwoche 49 Dezember 2021'
    },
    {
      'order': 11,
      'name': 'Sa. 11.12.2021',
      'group': 'Kalenderwoche 49 Dezember 2021'
    },
    {
      'order': 12,
      'name': 'So. 12.12.2021',
      'group': 'Kalenderwoche 49 Dezember 2021'
    },
  ];

  DateTime? selectedDate = DateTime.now().toLocal();
  final DateFormat formatter = DateFormat('MMM yyyy');
  String currentMothStr =
      DateFormat('MMM yyyy').format(DateTime.now().toLocal());
  // int currentMonth = 1;

//testing grouper_list -JP(31.12.2021)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Einträge',
            style: TextStyle(color: Colors.blue),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                child: Text(currentMothStr),
                style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.blue),
                onPressed: () {
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: selectedDate ?? DateTime.now(),
                    locale: Locale("de"),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                        currentMothStr =
                            DateFormat('MMM yyyy', 'de').format(date);
                      });
                    }
                  });
                },
              ),
            ),
          ],
          backgroundColor: Colors.black),
      body: GroupedListView<dynamic, String>(
        elements: _elements,
        groupBy: (element) => element['group'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1['order'].compareTo(item2['order']),
        order: GroupedListOrder.ASC,
        useStickyGroupSeparators: false,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (c, element) {
          return Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Icon(Icons.event),
                title: Text(element['name']),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          );
        },
      ),
    );
  }
}
