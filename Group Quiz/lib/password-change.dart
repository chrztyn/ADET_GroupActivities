import 'dart:io';
import 'models.dart';

class PasswordChange {
  static void changePassword(Person user) {
    // Ask for old password
    String oldPw = "";
    while (true) {
      stdout.write("Enter old password: ");
      oldPw = stdin.readLineSync()?.trim() ?? "";

      if (oldPw == user.password) {
        break;
      } else {
        stdout.writeln("Incorrect password. Try again.\n");
      }
    }

    // Ask for new password
    String newPw = "";
    while (true) {
      stdout.write("Enter new password: ");
      newPw = stdin.readLineSync()?.trim() ?? "";

      if (newPw.length < 8) {
        stdout.writeln("Password must be at least 8 characters long.\n");
        continue;
      }

      if (newPw == user.password) {
        stdout.writeln("New password must be different from old password.\n");
        continue;
      }

      break;
    }

    // Ask to confirm new password
    while (true) {
      stdout.write("Confirm new password: ");
      String confirmPw = stdin.readLineSync()?.trim() ?? "";

      if (confirmPw == newPw) {
        break; // confirmed correctly
      } else {
        stdout.writeln("Passwords do not match. Please try again.\n");
      }
    }

    // Update password
    user.password = newPw;
    user.failedAttempts = 0;
    user.isLocked = false;

    stdout.writeln("Password changed successfully.\n");
  }
}
