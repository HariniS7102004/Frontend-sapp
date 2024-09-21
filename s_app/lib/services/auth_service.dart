import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<void> authenticateUser(
    String email,
    String password,
    bool isLogin,
    BuildContext context,
  ) async {
    var url = Uri.parse(isLogin
        ? 'http://127.0.0.1:8000/api/login/' 
        : 'http://127.0.0.1:8000/api/signup/' 
    );
    http.Response? response;
    try {
      response = await http.post(
        url,
        body: {'email': email, 'password': password},
      );
      
    } catch (error) {
      _showDialog(context, 'Error', 'An error occurred: $error', Colors.red);
    } finally{
      if (response!=null && response.statusCode == 200 && isLogin) {
        _showDialog(context, 'Success', 'Login Successful!', Colors.green);
      } else if (response!=null && response.statusCode == 201 && !isLogin) {
        _showDialog(context, 'Success', 'Signup Successful!', Colors.green);
      } else if (response!=null && response.statusCode == 400 && !isLogin) {
        _showDialog(context, 'Error', 'Password must have at least 8 characters', Colors.red);
      } else if (response!=null && response.statusCode == 400 && isLogin) {
        _showDialog(context, 'Error', 'Invalid Credentials or New User, Please Sign Up', Colors.red);
      }
    }
  }

  static void _showDialog(BuildContext context, String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: color)),
          content: Text(message, style: TextStyle(fontSize: 20)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
