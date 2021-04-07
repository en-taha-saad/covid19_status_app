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
      darkTheme: ThemeData.dark(),
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

  getAccessToken() async {
    final apiService = APIService(API.sandbox());
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndPointData(
        accessToken: accessToken, endpoint: Endpoints.cases);
    setState(() {
      _accessToken = accessToken;
      _cases = cases;
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
            Text('$_cases'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: getAccessToken),
    );
  }
}
