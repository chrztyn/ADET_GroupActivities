import 'dart:io';
import 'models.dart';

class AuthLogin {
  static Person? login(List<Person> users) {

    // Check if any users exist
    if (users.isEmpty) {
      stdout.writeln('No users registered yet.');
      return null;
    }

    // Get username or email input
    stdout.write('Enter username or email: ');
    final usernameInput = stdin.readLineSync()?.trim() ?? '';
    final user = _findByUsername(users, usernameInput);

    // Stop if user not found
    if (user == null) {
      stdout.writeln('User not found.');
      return null;
    }

    // Reset failed attempts for a fresh login
    user.failedAttempts = 0;

    // Allow up to 3 password attempts
    for (var attempt = 1; attempt <= 3; attempt++) {
      stdout.write('Enter password: ');
      final pw = stdin.readLineSync() ?? '';

      // Successful login
      if (pw == user.password) {
        stdout.writeln('Login successful.');
        user.failedAttempts = 0;
        return user;
      } else {
        // Track failed attempts
        user.failedAttempts++;
        stdout.writeln('Incorrect password. Attempt $attempt of 3.');

        // Lock account after 3 failed attempts
        if (user.failedAttempts >= 3) {
          stdout.writeln('Account locked. Please contact admin.');
          return null;
        }
      }
    }
    return null;
  }
}

// Find by username or email
Person? _findByUsername(List<Person> users, String usernameOrEmail) {
  final lookup = usernameOrEmail.toLowerCase();
  for (final user in users) {
    if (user.name.toLowerCase() == lookup ||
        user.email.toLowerCase() == lookup) {
      return user;
    }
  }
  return null;
}
