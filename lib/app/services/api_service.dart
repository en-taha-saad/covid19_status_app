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
}
