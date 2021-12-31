import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tima/data/database.dart';
import 'package:tima/models/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<User> user;

  @override
  void initState() {
    super.initState();
    user = DBProvider.instance.getAktivUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 280, // MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.account_circle_outlined,
                                size: 150,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(children: [
                                Text(
                                  snapshot.data!.name,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 24.0,
                                    letterSpacing: 1.5,
                                  ),
                                )
                              ])
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('PersNr.:',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                    letterSpacing: 1.5,
                                  )),
                              Text(snapshot.data!.persnr.toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                    letterSpacing: 1.5,
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Benutzerinformationen',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18.0,
                            letterSpacing: 1.5,
                          )),
                      Divider(
                        height: 20,
                        thickness: 2,
                        color: Colors.blue,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Servicebüro: '),
                              Text('Wochenarbeitszeit: ')
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.office),
                              Row(
                                children: [
                                  Text(snapshot.data!.weeklyhours.toString()),
                                  Text(' h')
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
