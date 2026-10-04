import 'package:flutter/material.dart';
import 'package:sandbox_app1/models/user.dart';

class RegistrationPage extends StatefulWidget {
  const new({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _login = "";
  String _password = "";
  String _passwordConfirmation = "";
  String? _globalError;

  void _showAlertDialog() {
    AlertDialog alert = AlertDialog(
      title: Text("Вы успешно зарегестрировались!"),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Закрыть"),
        ),
        TextButton(
          onPressed: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
          child: Text("На страницу входа"),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }

  void _submitForm() {
    setState(() {
      _globalError = null;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_password != _passwordConfirmation) {
        _globalError = "Пароль и его подтверждение не совпадают";
        return;
      }

      tempUsersList.add(User(name: _name, login: _login, password: _password));

      _formKey.currentState!.reset();

      _showAlertDialog();
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
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите имя";
                      }
                      return null;
                    },
                    onSaved: (newValue) => _name = newValue!,
                    decoration: InputDecoration(
                      hint: Text("Имя"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

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
                    decoration: InputDecoration(
                      hint: Text("Пароль"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  TextFormField(
                    onSaved: (newValue) => _passwordConfirmation = newValue!,
                    obscureText: true,
                    decoration: InputDecoration(
                      hint: Text("Подтверждение пароля"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  if (_globalError != null)
                    Text(_globalError!, style: TextStyle(color: Colors.red)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text("Есть аккаунт?"),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Вход"),
                      ),
                    ],
                  ),

                  FilledButton(
                    onPressed: _submitForm,
                    child: Center(
                      child: Text(
                        "Зарегистрироваться",
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
