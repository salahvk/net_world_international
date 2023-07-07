import 'package:http/http.dart' as http;
import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:net_world_international/domain/core/api_endpoint.dart';

Future<bool> validateUrl() async {
  try {
    final endPoint = UrlController.url.text;
    final apiUrl = "$endPoint${ApiEndPoint.getItemConfig}";
    final url = Uri.parse(apiUrl);
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(
      url,
      headers: headers,
    );
    // log(response.body);
    // var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {}
  } catch (e) {
    print(e);
  }
  return false;
}
