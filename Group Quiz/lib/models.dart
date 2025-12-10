abstract class Person {
  String _name;
  String _email;
  String _password;
  int failedAttempts = 0;
  bool isLocked = false;

  Person(this._name, this._email, this._password);

  String get name => _name;
  String get email => _email;
  String get password => _password;

  set name(String n) => _name = n;
  set email(String e) => _email = e;
  set password(String p) => _password = p;

  void display();
}

class Student extends Person {
  int _studnum;

  Student(String name, String email, String password, this._studnum) : super(name, email, password);

  int getNum() => _studnum;

  @override
  void display() {
    print("STUDENT | Name: $name | Email: $email | Student No: $_studnum");
  }
}

class Employee extends Person {
  int _empnum;
  Employee(String name, String email, String password, this._empnum) : super(name, email, password);

  int getNum() => _empnum;

  @override
  void display() {
    print("EMPLOYEE | Name: $name | Email: $email | Employee No: $_empnum");
  }
}
