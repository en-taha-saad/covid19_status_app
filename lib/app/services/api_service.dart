import 'dart:convert' as convert;

import 'package:covid19_status_app/app/services/api.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService(this.api);
  final API api;
  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
      'Request ${api.apiKey} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}',
    );
    throw response;
  }

  Future<int> getEndPointData({
    required String accessToken,
    required Endpoints endpoint,
  }) async {
    final response = await http.get(
      api.endpointsUri(endpoint),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      List<dynamic> data = convert.jsonDecode(response.body);
      if (data.isNotEmpty) {
        Map<String, dynamic> endpointData = data[0];
        final String? responseJsonKey = _responsesJsonKeys[endpoint];
        final int result = endpointData[responseJsonKey];
        return result;
      }
    }
    print(  
      'Request ${api.apiKey} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}',
    );
    throw response;
  }

  static Map<Endpoints, String> _responsesJsonKeys = {
    Endpoints.cases: "cases",
    Endpoints.casesConfirmed: "data",
    Endpoints.deaths: "data",
    Endpoints.recovered: "data",
    Endpoints.casesSuspected: "data"
  };
}
