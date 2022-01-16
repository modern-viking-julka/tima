import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

class DayEntryPage extends StatefulWidget {
  DayEntryPage({Key? key, @required this.dayEntryId, required this.dayDate})
      : super(key: key);

  final int? dayEntryId;
  final DateTime dayDate;

  @override
  _DayEntryPageState createState() => _DayEntryPageState();
}

class _DayEntryPageState extends State<DayEntryPage> {
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
                onTap: () {
                  //Save changes and get back to timeoverview_page -JP(16.01.2022)
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
        body: Center(child: Text(widget.dayDate.toString())));
  }
}
