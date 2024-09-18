import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(SchoolApp());
}

class SchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> authenticateUser(String email, String password) async {
  var url = Uri.parse(isLogin
      ? 'http://127.0.0.1:8000/api/login/'  // Login endpoint
      : 'http://127.0.0.1:8000/api/signup/' // Signup endpoint
      );

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
      // Show success message or navigate to another page
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
                  // You can navigate to another page here if needed
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // If the response is not successful, show an error dialog
      _showErrorDialog('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  } catch (error) {
    // Handle exceptions like network issues
    _showErrorDialog('An error occurred: $error');
  }
}

// Function to show an error dialog
void _showErrorDialog(String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8399f9), //0xFF91A4FC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, color: Colors.white, fill: 1),
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
              Container(
                height: 500,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isLogin = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isLogin ? Color(0xff8399f9) : Colors.white,
                              foregroundColor:
                                  isLogin ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                              ),
                              side: BorderSide(color: Color(0xff8399f9)),
                            ),
                            child: Text('Login'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isLogin = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isLogin ? Colors.white : Color(0xff8399f9),
                              foregroundColor:
                                  isLogin ? Colors.black : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              side: BorderSide(color: Color(0xff8399f9)),
                            ),
                            child: Text('Signup'),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      //Getting user inputs
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'E-mail',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: mailController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Enter your E-mail',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xff8399f9),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            /*borderSide: BorderSide(
                              //width: 1,
                              color: Color(0xff5f7bf7),
                              style: BorderStyle.solid,
                            ),*/
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Enter your Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff8399f9),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !(isPasswordVisible);
                              });
                            },
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xff8399f9),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                        ),
                        obscureText: isPasswordVisible ? false : true,
                      ),
                      SizedBox(height: 16),
                      if (!isLogin) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        //SizedBox(height: 16),
                        TextField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: 'Re-enter Password',
                            /*confirmPasswordController != passwordController
                                    ? 'Enter same password as given above'
                                    : 'Re-enter Password',*/
                            //confirmPasswordText,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff8399f9),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !(isConfirmPasswordVisible);
                                });
                              },
                              child: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff8399f9),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                          ),
                          obscureText: isConfirmPasswordVisible ? false : true,
                        ),
                        SizedBox(height: 16),
                      ],
                      if (isLogin) ...[
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Forgot password?', //use gesture detector (on tap)
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                      //SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (mailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  /*title: Text(
                                    'M',
                                    style: TextStyle(color: Colors.red),
                                  ),*/
                                  content: Text(
                                    mailController.text.isEmpty
                                        ? 'Enter an e-mail'
                                        : 'Enter the password',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); 
                                      },
                                      child: Text(''),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (isLogin == false &&
                              confirmPasswordController.text !=
                                  passwordController.text) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Password mismatch',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: Text(
                                    'Enter the same password',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text(''),
                                    ),
                                  ],
                                );
                              },
                            );
                            /*SizedBox(
                              height: 1666,
                              child: Text(
                                'Enter same password',
                                style: TextStyle(color: Colors.red),
                              ),
                            );*/
                          } else {
                            authenticateUser(
                                mailController.text, passwordController.text);
                            //print(mailController.text);
                            //print(passwordController.text);
                          };
                        }, //page after login
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff8399f9),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            isLogin ? 'Login' : 'Signup',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      if (isLogin)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Not have an account? "),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLogin = false;
                                });
                              },
                              child: Text(
                                "Signup now",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//To run, cd . , flutter run


/*import 'package:flutter/material.dart';
import 'screens/login_signup.dart';

void main() {
  runApp(SchoolApp());
}

class SchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}*/

