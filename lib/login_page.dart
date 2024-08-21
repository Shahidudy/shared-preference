import 'package:flutter/material.dart';
import 'package:shared_pref_example/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emialController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    checkAndGetUserdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100, bottom: 70),
              child: Center(
                  child: Text(
                'Welcome to Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              )),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emialController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your email',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your password',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  saveUserDetails();
                },
                child: Text('Login'))
          ],
        ),
      ),
    );
  }

  Future checkAndGetUserdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (email != null && password != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    }
  }

  Future saveUserDetails() async {
    setState(() {
      isLoading = true;
    });
    String email = emialController.text;
    String password = passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password'),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }
}
