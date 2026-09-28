class User {
  String name;
  final String _login;
  final String _password;

  User({required this.name, required this._login, required this._password});

  String get login => _login;
  String get password => _password;
}

List<User> tempUsersList = [
  User(name: "user1", login: "login", password: "password"),
];
