import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tima/data/database.dart';
import 'package:tima/models/user.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Future<List<User>> fetchUsersFromDatabase(BuildContext context) async {
    Future<List<User>> users = DBProvider.instance.getUsers();
    return users;
  }

  @override
  Widget build(BuildContext context) {
    var _users = fetchUsersFromDatabase(context);
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Benutzer Liste',
              style: TextStyle(color: Colors.blue),
            ),
            backgroundColor: Colors.black),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.black,
          child: FutureBuilder<List<User>>(
              future: _users,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(snapshot.data![index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            color: Colors.grey)),
                                    Row(
                                      children: <Widget>[
                                        Text(snapshot.data![index].office,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                color: Colors.grey)),
                                        Text(
                                          ' - PersNr.: ',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                            snapshot.data![index].persnr
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Wochenarbeitszeit: ',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                            snapshot.data![index].weeklyhours
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                color: Colors.grey)),
                                        Text(' h',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                color: Colors.grey)),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                      splashColor: Colors.blue,
                                      onPressed: () {
                                        //delete user
                                        setState(() {
                                          DBProvider.instance
                                              .deleteUser(
                                                  snapshot.data![index].id)
                                              .then((value) {
                                            setState(() {
                                              //second setState, because of async method -jp(31.12.2021)
                                            });
                                          });
                                        });
                                      },
                                    ),
                                    // Text('Aktiv:'),
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: Colors.grey),
                                      child: Checkbox(
                                        value: snapshot.data![index].aktiv == 0
                                            ? false
                                            : true,
                                        onChanged: (newValue) {
                                          if (newValue! && newValue) {
                                            setState(() {
                                              DBProvider.instance
                                                  .setUserAktiv(
                                                      snapshot.data![index].id)
                                                  .then((value) {
                                                setState(() {
                                                  //second setState, because of async method -jp(31.12.2021)
                                                });
                                              });
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Divider(
                              thickness: 1.5,
                              color: Colors.blue,
                            ),
                          ],
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
