import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({required this.user});

  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello ${_currentUser.email}'),
        ),
        body: const Center(
          child: Text("Bonjour"),
        )
    );
  }
}