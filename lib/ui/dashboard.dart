import 'package:covid19_status_app/app/services/api.dart';
import 'package:flutter/material.dart';

import 'endpoint_card.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Covid19 Tracker'), centerTitle: true),
      body: Container(
        margin: EdgeInsets.only(top: 20, bottom: 10, left: 7, right: 7),
        child: ListView(
          children: <Widget>[
            EndpointCard(
endpoint: Endpoints.cases,
value: 345435645,
            ),
          ],
        ),
      ),
    );
  }
}
