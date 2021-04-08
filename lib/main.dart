import 'dart:io';

import 'package:flutter/material.dart';

import 'app/services/api.dart';
import 'app/services/api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken = '';
  int _cases = 0;
  int _casesConfirmed = 0;
  int _deaths = 0;
  int _recovered = 0;
  int _casesSuspected = 0;

  getAccessToken() async {
    final apiService = APIService(API.sandbox());
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndPointData(
      accessToken: accessToken,
      endpoint: Endpoints.cases,
    );
    final casesConfirmed = await apiService.getEndPointData(
      accessToken: accessToken,
      endpoint: Endpoints.casesConfirmed,
    );
    final deaths = await apiService.getEndPointData(
      accessToken: accessToken,
      endpoint: Endpoints.deaths,
    );
    final recovered = await apiService.getEndPointData(
      accessToken: accessToken,
      endpoint: Endpoints.recovered,
    );
    final casesSuspected = await apiService.getEndPointData(
      accessToken: accessToken,
      endpoint: Endpoints.casesSuspected,
    );
    setState(() {
      _accessToken = accessToken;
      _cases = cases;
      _casesConfirmed = casesConfirmed;
      _deaths = deaths;
      _recovered = recovered;
      _casesSuspected = casesSuspected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App')),
      body: Center(
        child: Column(
          children: [
            Text(_accessToken),
            if (Platform.isIOS) Text('cases: $_cases'),
            Text('casesConfirmed: $_casesConfirmed'),
            Text('casesSuspected: $_casesSuspected'),
            Text('recovered: $_recovered'),
            Text('deaths: $_deaths'),
            Switch(
              onChanged: (bool value) {},
              value: true,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: getAccessToken),
    );
  }
}
