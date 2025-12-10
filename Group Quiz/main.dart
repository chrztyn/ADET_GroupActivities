import 'dart:io';
import 'lib/models.dart';
import 'lib/authenticator.dart';
import 'lib/password-change.dart';
import 'lib/generator.dart';

void main() {
  List<Person> users = [];

  while (true) {
    showMenu();
    final choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1':
        registerStudent(users);
        break;
      case '2':
        registerEmployee(users);
        break;
      case '3':
        handleLogin(users);
        break;
      case '4':
        viewAllUsers(users);
        break;
      case '0':
        print('Exiting system. Goodbye!');
        return;
      default:
        print('Invalid option. Please try again.\n');
    }
  }
}

void showMenu() {
  print('========= USER ACCOUNT SYSTEM =========');
  print('[1] Register Student');
  print('[2] Register Employee');
  print('[3] Login');
  print('[4] View All Registered Users');
  print('[0] Exit');
  stdout.write('\nChoose an option: ');
}

void registerStudent(List<Person> users) {
  print('\n--- Student Registration ---');

  // Get student number
  int? tempStudnum;
  while (tempStudnum == null) {
    stdout.write('Enter student number: ');
    final studnumInput = stdin.readLineSync()?.trim() ?? '';
    tempStudnum = int.tryParse(studnumInput);

    if (tempStudnum == null) {
      print('Invalid student number. Please enter a valid integer.\n');
    }
  }

  final studnum = tempStudnum;

  // Get full name
  String tempName = '';
  while (tempName.isEmpty || !RegExp(r'^[a-zA-Z\s]+$').hasMatch(tempName)) {
    stdout.write('Enter full name: ');
    tempName = stdin.readLineSync()?.trim() ?? '';

    if (tempName.isEmpty) {
      print("Name cannot be empty. Please enter your full name.\n");
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(tempName)) {
      print("Name must contain letters only (no numbers or symbols).\n");
      tempName = '';
    }
  }

  final name = tempName;

  // Get email
  String tempEmail = '';
  while (tempEmail.isEmpty || !tempEmail.contains('@')) {
    stdout.write('Enter email: ');
    tempEmail = stdin.readLineSync()?.trim() ?? '';

    if (tempEmail.isEmpty) {
      print("Email cannot be empty. Please enter your email.\n");
    } else if (!tempEmail.contains('@')) {
      print("Invalid email. Email must contain '@'.\n");
      tempEmail = '';
    }
  }
  final email = tempEmail;

  // Generate username and temporary password
  String tempPass = generateTempPassword();
  String username = generateUsername(name, studnum);

  // Create student object
  Student s = Student(name, email, tempPass, username, studnum);
  users.add(s);

  // Confirmation
  print("\nWelcome ${s.name}");
  print("Your student number: $studnum");
  print("You registered email is: $email");
  print("Your username is:  $username");
  print("Your temporary password is: $tempPass\n");
}

void registerEmployee(List<Person> users) {
  print('\n--- Employee Registration ---');

  // Get employee number
  int? tempEmpnum;
  while (tempEmpnum == null) {
    stdout.write('Enter employee number: ');
    final input = stdin.readLineSync()?.trim() ?? '';
    tempEmpnum = int.tryParse(input);

    if (tempEmpnum == null) {
      print('Invalid employee number. Please enter a valid integer.\n');
    }
  }
  final empnum = tempEmpnum;

  // Get full name
  String tempName = '';
  while (tempName.isEmpty || !RegExp(r'^[a-zA-Z\s]+$').hasMatch(tempName)) {
    stdout.write('Enter full name: ');
    tempName = stdin.readLineSync()?.trim() ?? '';

    if (tempName.isEmpty) {
      print('Name cannot be empty. Please enter your full name.\n');
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(tempName)) {
      print('Name must contain letters and spaces only (no numbers or symbols).\n');
      tempName = '';
    }
  }
  final name = tempName;

  // Get email
  String tempEmail = '';
  while (tempEmail.isEmpty || !tempEmail.contains('@')) {
    stdout.write('Enter HAU email: ');
    tempEmail = stdin.readLineSync()?.trim() ?? '';

    if (tempEmail.isEmpty) {
      print("Email cannot be empty. Please enter your email.\n");
    } else if (!tempEmail.contains('@')) {
      print("Invalid email. Email must contain '@'.\n");
      tempEmail = '';
    }
  }

  final email = tempEmail;

  // Generate username and temporary password
  String tempPass = generateTempPassword();
  final username = generateUsername(name, empnum);

  // Create employee object
  Employee e = Employee(name, email, tempPass, username, empnum);
  users.add(e);

  // Confirmation
  print("\nWelcome ${e.name}");
  print("Your employee number: $empnum");
  print("You registered email is: $email");
  print("Your username is: $username");
  print("Your temporary password is: $tempPass\n");
}

void handleLogin(List<Person> users) {
  print('\n--- Login ---');

  final loggedInUser = AuthLogin.login(users);

  if (loggedInUser != null) {
    print('\nYou must change your password.');
    PasswordChange.changePassword(loggedInUser);
    print('');
  } else {
    print('');
  }
}

void viewAllUsers(List<Person> users) {
  print('\n--- Registered Users ---');

  if (users.isEmpty) {
    print('No users registered yet.\n');
    return;
  }

  // Polymorphism: treating Student and Employee as Person
  for (final user in users) {
    user.display();
  }
  print('');
}
