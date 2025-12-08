import 'dart:io';

void main() {
  // Inputs
  stdout.write("Enter Student Name: ");
  String name = stdin.readLineSync() ?? "";

  //Input Validation
  int studentNumber = 0;
  while (true) {
    stdout.write("Enter Student Number: ");
    String? input = stdin.readLineSync();

    int? number = int.tryParse(input ?? "");

    if (number != null && number > 0) {
      studentNumber = number;
      break;
    } else {
      print("Invalid input. Please enter a positive whole number.");
    }
  }
  stdout.write("Enter Course: ");
  String course = stdin.readLineSync() ?? "";

  //Input Validation
  int yearLevel = 0;
  while (true) {
    stdout.write("Enter Year Level: ");
    String? levelInput = stdin.readLineSync();

    int? level = int.tryParse(levelInput ?? "");
    if (level != null && level >= 1 && level <= 4) {
      yearLevel = level;
      break;
    } else {
      print("Invalid year level. Please enter a number from 1 to 4.");
    }
  }
}
