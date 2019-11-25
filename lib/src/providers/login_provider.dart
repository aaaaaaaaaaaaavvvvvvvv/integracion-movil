import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider {
  login(String username, String password) async {
    print(username + ' ==> ' + password);

    final authData = {
      'usuario': username,
      'clave': password,
    };

    final header = {'Content-type': 'application/json'};

    final resp = await http.post(
        'https://negelec-gutynatura.herokuapp.com/login',
        body: json.encode(authData),
        headers: {'Content-type': 'application/json'});
    if (resp.body == null) {
      return null;
    } else {
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      return decodedResp;
    }
  }
}
