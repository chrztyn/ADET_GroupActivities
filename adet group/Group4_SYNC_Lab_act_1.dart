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

  // Course code and units input
  List<String> courses = [];
  Map<String, int> units = {};

  while (true) {
    stdout.write("Enter course code (or 'done' to finish): ");
    String? courseInput = stdin.readLineSync();

    if (courseInput?.toLowerCase() == 'done') {
      break;
    }

    if (courseInput == null || courseInput.isEmpty) {
      print("Invalid input. Please enter a course code.");
      continue;
    }

    //Check for duplicate course code
    if (courses.contains(courseInput)) {
      print("Course code already exists. Please enter a different course.");
      continue;
    }

    // Input validation for units
    int courseUnits = 0;
    while (true) {
      stdout.write("Enter units: ");
      String? unitsInput = stdin.readLineSync();

      int? parsedUnits = int.tryParse(unitsInput ?? "");

      if (parsedUnits != null && parsedUnits > 0) {
        courseUnits = parsedUnits;
        break;
      } else {
        print("Invalid input. Please enter a positive whole number.");
      }
    }
    courses.add(courseInput);
    units[courseInput] = courseUnits;
    print("Added: $courseInput ($courseUnits units)");
  }
}
