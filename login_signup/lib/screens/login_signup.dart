/*import 'package:flutter/material.dart';
import '../widgets/form_field.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;  // Toggle between login and signup forms
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8399f9),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'School Camp',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              buildLoginSignupForm(context),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin; // Toggle between Login and Signup
                  });
                },
                child: Text(isLogin ? 'Don\'t have an account? Sign Up' : 'Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginSignupForm(BuildContext context) {
    return Container(
      height: isLogin ? 350 : 420, // Adjust form size for signup
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xffffffff),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isLogin ? 'Login Form' : 'Signup Form',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              controller: mailController,
              label: 'E-mail',
              icon: Icons.email,
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              controller: passwordController,
              label: 'Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            if (!isLogin)
              Column(
                children: [
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                ],
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (isLogin || passwordController.text == confirmPasswordController.text) {
                  try {
                    await _authService.authenticateUser(
                      mailController.text,
                      passwordController.text,
                      isLogin,
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Success'),
                          content: Text('Login or Signup Successful!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } catch (error) {
                    _showErrorDialog(context, 'Error: $error');
                  }
                } else {
                  _showErrorDialog(context, 'Passwords do not match.');
                }
              },
              child: Text(isLogin ? 'Login' : 'Signup'),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}*/
