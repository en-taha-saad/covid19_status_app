import '../services/api.dart';

import '../services/api_service.dart';

class DataRepository {
  DataRepository({required this.apiService});
  final APIService apiService;
  String? _accessToken;

  Future<int> getEndpointData(Endpoints endpoint) async {
    _accessToken = await apiService.getAccessToken();
    await apiService.getEndPointData(
      accessToken: _accessToken!,
      endpoint: endpoint,
    );
    String accessToken = '';
    throw accessToken;
  }
}
