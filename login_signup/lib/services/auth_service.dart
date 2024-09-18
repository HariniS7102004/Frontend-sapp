/*import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<void> authenticateUser(
      String email, String password, bool isLogin) async {
    var url = Uri.parse(isLogin
        ? 'http://127.0.0.1:8000/api/login/'
        : 'http://127.0.0.1:8000/api/signup/');

    try {
      var response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('Success: $jsonData');
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}*/
