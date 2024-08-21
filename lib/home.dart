import 'package:flutter/material.dart';
import 'package:shared_pref_example/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 107, 226, 86),
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.transparent,
        actions: [
          ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (ctx) => LoginPage()));
              },
              child: Icon(
                Icons.logout,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'WELCOME TO OUR OWN WORLD',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}
