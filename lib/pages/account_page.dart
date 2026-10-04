import 'package:flutter/material.dart';
import 'package:sandbox_app1/models/user.dart';
import 'package:sandbox_app1/pages/login_page.dart';

class AccountPage extends StatelessWidget {
  final User _user;

  const new({required this._user, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text(_user.name),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [Text("Выйти"), Icon(Icons.logout)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
