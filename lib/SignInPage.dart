import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignUpPage.dart';
import 'Services.dart';

class SignInPage extends StatefulWidget {
  @override
  final Services services;
  const SignInPage({super.key, required this.services});
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _email.addListener(enableButton);
    _password.addListener(enableButton);
  }

  void enableButton() {
    setState(() {
      isButtonEnabled = _email.text.isNotEmpty && _password.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Enter Email and password to log in',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                labelText: 'Email ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: isButtonEnabled ? () async {
                try {
                  await widget.services.SignIn(_email.text, _password.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        services: widget.services,
                      ),
                    ),
                  );
                } catch (e) {
                  print('Provide correct credentials: $e');
                  
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                     content: Text('Provide correct credentials'),
                   ));
                }
              } : null,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await widget.services.oauth_google();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      services: widget.services,
                    ),
                  ),
                );
              },
              child: Text('Login with Google'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await widget.services.oauth_facebook();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      services: widget.services,
                    ),
                  ),
                );
              },
              child: Text('Login with Facebook'),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(
                      services: widget.services,
                    ),
                  ),
                );
              },
              child: Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
