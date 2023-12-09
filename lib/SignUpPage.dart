import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignInPage.dart';
import 'Services.dart';

class SignUpPage extends StatefulWidget {
  final Services services;
  
  const SignUpPage({Key? key, required this.services}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Become a Member',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  controller: _name,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email I.D',
                    border: OutlineInputBorder(),
                    errorText: isEmailValid ? null : 'Please enter a valid email (e.g., example@gmail.com)',
                  ),
                  controller: _email,
                  onChanged: (value) {
                    setState(() {
                      isEmailValid = value.contains('@gmail.com');
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    errorText: isPasswordValid ? null : 'Password should be at least 8 characters',
                  ),
                  controller: _password,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      isPasswordValid = value.length >= 8;
                    });
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: isEmailValid && isPasswordValid
                      ? () {
                          widget.services.SignUp(_name.text, _email.text, _password.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(services: widget.services)),
                          );
                        }
                      : null,
                  child: Text('Proceed'),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage(services: widget.services)),
                    );
                  },
                  child: Text(
                    'Already have an account? Sign In',
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
        ),
      ),
    );
  }
}

