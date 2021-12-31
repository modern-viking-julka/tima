import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tima/data/database.dart';
import 'package:tima/models/user.dart';
import 'users_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  // variables
  String _name = '';
  int _persnr = 0;
  int _workinghours = 0;
  String _officelocation = '';

  Widget _buildNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
        labelText: 'Vorname, Nachname',
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.grey),
      validator: (value) {
        if (["", null, false, 0].contains(value)) {
          return 'Bitte Vorname und Nachname eingeben!';
        }
      },
      onSaved: (value) {
        _name = value.toString();
      },
    );
  }

  Widget _buildPersNrField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 7,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
        labelText: 'PersNr.',
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.grey),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (value) {
        var _validNr = int.tryParse(value.toString()) ?? 0;
        if (_validNr.toString().length != 7) {
          return 'Die PersNr. muss 7 Zahlen langt sein!';
        }
      },
      onSaved: (value) {
        _persnr = int.tryParse(value.toString()) ?? 0;
      },
    );
  }

  Widget _buildWorkinghoursField() {
    return TextFormField(
      enabled: false,
      initialValue: '35',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
        labelText: 'Wochenarbeitszeit (h)',
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.grey),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (value) {
        var zahl = int.tryParse(value.toString()) ?? 0;
        if (zahl != 35) {
          return 'Es ist nur 35h erlaubt!';
        }
      },
      onSaved: (value) {
        _workinghours = int.tryParse(value.toString()) ?? 0;
      },
    );
  }

  Widget _buildOfficelocationField() {
    //later as DropDown List, if there are more choices available!
    return TextFormField(
      enabled: false,
      initialValue: 'Hamburg',
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
        labelText: 'Servicebüro',
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.grey),
      validator: (value) {
        if (["", null, false, 0].contains(value)) {
          return 'Bitte einen Servicebüro eingeben!';
        }
      },
      onSaved: (value) {
        _officelocation = value.toString();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Benutzerinformationen',
          style: TextStyle(color: Colors.blue),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.view_list),
            tooltip: 'User List',
            onPressed: () {
              navigateToUserList();
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //Vorname, Nachname
                  _buildNameField(),
                  SizedBox(height: 20),
                  _buildPersNrField(),
                  SizedBox(height: 20),
                  _buildOfficelocationField(),
                  SizedBox(height: 20),
                  _buildWorkinghoursField(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // reset() set all fields to Inital value
                          _formKey.currentState!.reset();
                        },
                        child: Text('Felder Leeren'),
                      ),
                      SizedBox(width: 25),
                      ElevatedButton(
                        onPressed: () async {
                          //if all validators are properly set
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            User neueUser = User(
                              name: _name,
                              office: _officelocation,
                              weeklyhours: _workinghours,
                              persnr: _persnr,
                              aktiv: 0,
                            );
                            await DBProvider.instance.newUser(neueUser);
                            _formKey.currentState!.reset();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Benutzer gespeichert"),
                            ));
                            navigateToUserList();
                          }
                        },
                        child: Text('Speichern'),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  void navigateToUserList() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UsersPage()));
  }
}
