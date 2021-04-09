import 'package:covid19_status_app/app/repositories/data_repository.dart';
import 'package:covid19_status_app/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'endpoint_card.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int? _cases;
  int? _casesSuspected;
  int? _casesConfirmed;
  int? _deaths;
  int? _recovered;
  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndpointData(Endpoints.cases);
    final casesSuspected =
        await dataRepository.getEndpointData(Endpoints.casesSuspected);
    final casesConfirmed =
        await dataRepository.getEndpointData(Endpoints.casesConfirmed);
    final deaths = await dataRepository.getEndpointData(Endpoints.deaths);
    final recovered = await dataRepository.getEndpointData(Endpoints.recovered);
    setState(() {
      _cases = cases;
      _casesSuspected = casesSuspected;
      _casesConfirmed = casesConfirmed;
      _deaths = deaths;
      _recovered = recovered;
    });
  }

  @override
  void initState() {
    _updateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Covid19 Tracker'), centerTitle: true),
      body: RefreshIndicator(
        child: ListView(
          children: <Widget>[
            EndpointCard(
              endpoint: Endpoints.cases,
              value: _cases,
            ),
            EndpointCard(
              endpoint: Endpoints.casesSuspected,
              value: _casesSuspected,
            ),
            EndpointCard(
              endpoint: Endpoints.casesConfirmed,
              value: _casesConfirmed,
            ),
            EndpointCard(
              endpoint: Endpoints.deaths,
              value: _deaths,
            ),
            EndpointCard(
              endpoint: Endpoints.recovered,
              value: _recovered,
            ),
          ],
        ),
        onRefresh: _updateData,
      ),
    );
  }
}
