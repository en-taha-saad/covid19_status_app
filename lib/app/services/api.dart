import 'api_keys.dart';

enum Endpoints { cases, casesSuspected, casesConfirmed, deaths, recovered }

class API {
  API({this.apiKey = ''});
  final String apiKey;
  factory API.sandbox() => API(apiKey: APIKeys.covidSandboxKey);
  String host = 'ncov2019-admin.firebaseapp.com';
  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );

  Uri endpointsUri(Endpoints endpoint) => Uri(
        scheme: 'https',
        host: host,
        path: _paths[endpoint],
      );

  Map<Endpoints, String> _paths = {
    Endpoints.cases: "cases",
    Endpoints.casesConfirmed: "casesConfirmed",
    Endpoints.deaths: "deaths",
    Endpoints.recovered: "recovered",
    Endpoints.casesSuspected: "casesSuspected"
  };
}
