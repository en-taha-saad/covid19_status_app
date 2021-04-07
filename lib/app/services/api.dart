import 'api_keys.dart';

class API {
  API({this.apiKey = ''});
  final String apiKey;
  factory API.sandbox() => API(apiKey: APIKeys.covidSandboxKey);
  Uri tokenUri() => Uri(
        scheme: 'https',
        host: 'ncov2019-admin.firebaseapp.com',
        path: 'token',
      );
}
