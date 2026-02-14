import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
