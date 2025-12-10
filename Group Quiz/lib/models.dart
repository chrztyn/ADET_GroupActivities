abstract class Person {
  String _name;
  String _email;
  String _username;
  String _password;
  int failedAttempts = 0;
  bool isLocked = false;

  Person(this._name, this._email, this._password, this._username);

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get username => _username;

  set name(String n) => _name = n;
  set email(String e) => _email = e;
  set password(String p) => _password = p;
  set username(String u) => _username = u;

  void display();
}

class Student extends Person {
  int _studnum;

  Student(String name, String email, String password, String username, this._studnum)
    : super(name, email, password, username);

  int getNum() => _studnum;

  @override
  void display() {
    print("STUDENT | Name: $name | Email: $email | Student No: $_studnum");
  }
}

class Employee extends Person {
  int _empnum;
  Employee(String name, String email, String password, String username, this._empnum)
    : super(name, email, password, username);

  int getNum() => _empnum;

  @override
  void display() {
    print("EMPLOYEE | Name: $name | Email: $email | Employee No: $_empnum");
  }
}
