import 'dart:io';

void main() {
  // Input: Student Name
  stdout.write("Enter Student Name: ");
  String name = stdin.readLineSync() ?? "";

  while (name.trim().isEmpty || RegExp(r'[0-9]').hasMatch(name)) {
    print("Error: Student name cannot contain numbers.");
    stdout.write("Enter Student Name: ");
    name = stdin.readLineSync() ?? "";
  }

  // Input Validation: Student Number
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

  // Input: Course
  stdout.write("Enter Course (e.g., BSIT in Networking): ");
  String course = stdin.readLineSync() ?? "";

  // Input Validation: Year Level 1–4
  int yearLevel = 0;
  while (true) {
    stdout.write("Enter Year Level (1-4): ");
    String? levelInput = stdin.readLineSync();

    int? level = int.tryParse(levelInput ?? "");
    if (level != null && level >= 1 && level <= 4) {
      yearLevel = level;
      break;
    } else {
      print("Invalid year level. Please enter a number from 1 to 4.");
    }
  }

  // Course Code and Units Input
  List<String> courses = [];
  Map<String, int> units = {};

  print("\nEnter enrolled courses one by one.");
  print('Type "done" when you are finished.\n');

  while (true) {
    stdout.write("Enter course code (or 'done' to finish): ");
    String? courseInput = stdin.readLineSync();

    if (courseInput == null) continue;

    courseInput = courseInput.trim().toUpperCase();

    // If user types DONE
    if (courseInput.toLowerCase() == 'done') {
      if (courses.isEmpty) {
        print("You must enter at least one course before finishing.");
        continue;
      } else {
        printSummary(courses, units, name, studentNumber, yearLevel, course);
        break;
      }
    }

    if (courseInput.isEmpty) {
      print("Invalid input. Please enter a course code.");
      continue;
    }

    // Duplicate course validation
    if (courses.contains(courseInput)) {
      print("Course code already exists. Please enter a different course.");
      continue;
    }

    // Course format: must start with a number + contain letters/numbers only
    RegExp coursePattern = RegExp(r'^[0-9][A-Za-z0-9]*$');
    if (!coursePattern.hasMatch(courseInput)) {
      print("Invalid course code format. Must start with a number and contain letters/numbers only.");
      continue;
    }

    if (courseInput.contains(' ')) {
      print("Invalid input. Course code cannot contain spaces.");
      continue;
    }

    // Units input
    int courseUnits = 0;
    while (true) {
      stdout.write("Enter number of units for $courseInput: ");
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
    print("Added: $courseInput ($courseUnits units)\n");
  }
}



// Print Summary Function
void printSummary(List<String> courses, Map<String, int> units, String name, int studentNumber, int yearLevel, String course) {
  // Sort course codes alphabetically
  courses.sort();

  // Compute totals
  int totalSubjects = courses.length;
  int totalUnits = units.values.fold(0, (sum, val) => sum + val);

  // Convert year level to readable format
  String yearText;
  switch (yearLevel) {
    case 1:
      yearText = "1st Year";
      break;
    case 2:
      yearText = "2nd Year";
      break;
    case 3:
      yearText = "3rd Year";
      break;
    case 4:
      yearText = "4th Year";
      break;
    default:
      yearText = "$yearLevel Year";
  }

  // Final Summary Output
  print("\n========== SUMMARY ==========");
  print("Name: $name");
  print("Student Number: $studentNumber");
  print("Course: $course");
  print("Year Level: $yearText\n");

  print("Enrolled Courses:");
  for (var c in courses) {
    print("- $c (${units[c]} units)");
  }

  print("\nTotal Subjects: $totalSubjects");
  print("Total Units: $totalUnits");
  print("=============================");
}
