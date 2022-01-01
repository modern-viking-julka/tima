import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class TimeOverviewPage extends StatefulWidget {
  @override
  _TimeOverviewPageState createState() => _TimeOverviewPageState();
}

class _TimeOverviewPageState extends State<TimeOverviewPage> {
  List _elements = [
    {'name': 'A', 'group': 'Kalenderwoche 48 Dezember 2021'},
    {'name': 'B', 'group': 'Kalenderwoche 48 Dezember 2021'},
    {'name': 'C', 'group': 'Kalenderwoche 48 Dezember 2021'},
    {'name': 'D', 'group': 'Kalenderwoche 48 Dezember 2021'},
    {'name': 'E', 'group': 'Kalenderwoche 48 Dezember 2021'},
    {'name': 'F', 'group': 'Kalenderwoche 49 Dezember 2021'},
    {'name': 'G', 'group': 'Kalenderwoche 49 Dezember 2021'},
    {'name': 'H', 'group': 'Kalenderwoche 49 Dezember 2021'},
    {'name': 'I', 'group': 'Kalenderwoche 49 Dezember 2021'},
    {'name': 'J', 'group': 'Kalenderwoche 49 Dezember 2021'},
    {'name': 'K', 'group': 'Kalenderwoche 49 Dezember 2021'},
    {'name': 'L', 'group': 'Kalenderwoche 49 Dezember 2021'},
  ];
//testing grouper_list -JP(31.12.2021)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Einträge',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.black),
      body: GroupedListView<dynamic, String>(
        elements: _elements,
        groupBy: (element) => element['group'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1['name'].compareTo(item2['name']),
        order: GroupedListOrder.DESC,
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
