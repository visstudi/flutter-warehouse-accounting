import 'package:flutter/material.dart';
import 'package:sandbox_app1/models/user.dart';
import 'package:sandbox_app1/pages/home_page.dart';
import 'package:sandbox_app1/pages/registration_page.dart';
import 'package:collection/collection.dart';

class LoginPage extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _login = "";
  String _password = "";
  String _globalError = "";

  void _submitForm() {
    setState(() {
      _globalError = "";
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      User? matchedUser = tempUsersList.firstWhereOrNull(
        (user) => user.login == _login && user.password == _password,
      );

      if (matchedUser == null) {
        _globalError = "Неверный логин или пароль";
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(user: matchedUser)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите логин";
                      }
                      return null;
                    },
                    onSaved: (newValue) => _login = newValue!,
                    decoration: InputDecoration(
                      hint: Text("Логин"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите пароль";
                      }
                      return null;
                    },
                    onSaved: (newValue) => _password = newValue!,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: [AutofillHints.password],
                    decoration: InputDecoration(
                      hint: Text("Пароль"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  if (_globalError != "")
                    Text(_globalError, style: TextStyle(color: Colors.red)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text("Нет аккаунта?"),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationPage(),
                          ),
                        ),
                        child: Text("Регистрация"),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: _submitForm,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          "Войти",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
