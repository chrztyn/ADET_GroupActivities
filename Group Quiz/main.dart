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
  stdout.write('Choose an option: ');
}

void registerStudent(List<Person> users) {
  print('\n--- Student Registration ---');

  // Get student number
  stdout.write('Enter student number: ');
  final studnumInput = stdin.readLineSync()?.trim() ?? '';
  final studnum = int.tryParse(studnumInput);

  if (studnum == null) {
    print('Invalid student number. Registration cancelled.\n');
    return;
  }

  // Get full name
  stdout.write('Enter full name: ');
  final name = stdin.readLineSync()?.trim() ?? '';

  if (name.isEmpty) {
    print('Name cannot be empty. Registration cancelled.\n');
    return;
  }

  // Get email
  stdout.write('Enter HAU email: ');
  final email = stdin.readLineSync()?.trim() ?? '';

  if (email.isEmpty) {
    print('Email cannot be empty. Registration cancelled.\n');
    return;
  }

  // Generate temporary password
  final tempPass = generateTempPassword();

  // Create student object
  Student s = Student(name, email, tempPass, studnum);
  users.add(s);

  // Confirmation
  print("\nWelcome ${s.name}");
  print("You registered $email as your username");
  print("Your student number: $studnum");
  print("Your temporary password is: $tempPass\n");
}

void registerEmployee(List<Person> users) {
  print('\n--- Employee Registration ---');

  // Get employee number
  stdout.write('Enter employee number: ');
  final empnumInput = stdin.readLineSync()?.trim() ?? '';
  final empnum = int.tryParse(empnumInput);

  if (empnum == null) {
    print('Invalid employee number. Registration cancelled.\n');
    return;
  }

  // Get full name
  stdout.write('Enter full name: ');
  final name = stdin.readLineSync()?.trim() ?? '';

  if (name.isEmpty) {
    print('Name cannot be empty. Registration cancelled.\n');
    return;
  }

  // Get email
  stdout.write('Enter HAU email: ');
  final email = stdin.readLineSync()?.trim() ?? '';

  if (email.isEmpty) {
    print('Email cannot be empty. Registration cancelled.\n');
    return;
  }

  // Generate temporary password
  final tempPass = generateTempPassword();

  // Create employee object
  Employee e = Employee(name, email, tempPass, empnum);
  users.add(e);

  // Confirmation
  print("\nWelcome ${e.name}");
  print("You registered $email as your username");
  print("Your employee number: $empnum");
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
