import 'package:http/http.dart' as http;

class NetworkClient {
  final Uri url;

  NetworkClient(this.url);

  Future<dynamic> get() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> post(dynamic object) async {
    http.Response response = await http.post(url,headers: { "content-type" : "application/json",
      "accept" : "application/json",}, body: object);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      print(response.body);
    }
  }
}
