import 'dart:io';
import 'models.dart';

class PasswordChange {
  static void changePassword(Person user) {
    // Ask for old password
    stdout.write("Enter old password: ");
    final oldPw = stdin.readLineSync()?.trim() ?? "";

    // Validate old password
    if (oldPw != user.password) {
      stdout.writeln("Incorrect password. Password change cancelled.");
      return;
    }

    // Ask for new password
    stdout.write("Enter new password: ");
    final newPw = stdin.readLineSync()?.trim() ?? "";

    // Check length
    if (newPw.length < 8) {
      stdout.writeln("Password must be at least 8 characters long.");
      return;
    }

    // Check if different from old password
    if (newPw == oldPw) {
      stdout.writeln("New password must be different from old password.");
      return;
    }

    // Ask to confirm new password
    stdout.write("Confirm new password: ");
    final confirmPw = stdin.readLineSync()?.trim() ?? "";

    if (confirmPw != newPw) {
      stdout.writeln("Password do not match. Please try again.");
      return;
    }

    // Update password
    user.password = newPw;
    user.failedAttempts = 0;
    user.isLocked = false;

    stdout.writeln("Password changed successfully.");
  }
}
