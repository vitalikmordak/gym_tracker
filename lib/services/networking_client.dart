import 'package:http/http.dart' as http;

class NetworkClient {
  final Uri url;

  NetworkClient(this.url);

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
